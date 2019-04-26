module API
  module V1
    class Shops < Grape::API
      include Default
      include Grape::Rails::Cache

      #http_basic do |username, password|
      #  username == 'test' and password == 'hello'
      #end

      # before do
      #   unless request.headers['X-Api-Secret-Key'] == 'api_secret_key'
      #     # error! :forbidden, 403
      #     error!({code: 1, message: 'forbidden'}, 403)
      #   end
      # end

      desc 'find banner'
      params do
        use :id_validator
      end
      get 'banners/:id' do
        @banner = Banner.find(params[:id])
        @banner_items = @banner.banner_items.includes(:product, :image)
        banner_items = present @banner_items, with: API::Entities::BannerItem
        build_response code: 0, data: banner_items
      end

      desc 'find all themes'
      get 'themes' do
        @themes = Theme.all.includes(:head_image, :topic_image)
        themes = present @themes, with: API::Entities::ThemeIndex
        build_response code: 0, data: themes
     end

      desc 'find theme'
      params do 
        use :id_validator
      end
      get 'themes/:id' do
        @theme = Theme.includes([products: :image], :head_image).find(params[:id])
        if @theme
          theme = present @theme, with: API::Entities::Theme
          build_response code: 0, data: theme
        end
      end

      desc 'find recent product'
      get 'products/recent' do
        @products = Product.includes(:image).limit(10)
        products = present @products, with: API::Entities::ProductTheme
        build_response code: 0, data: products
      end

      desc 'find all categories'
      get 'categories' do
        @categories = Category.all
        categories = present @categories, with: API::Entities::Category
        build_response code: 0, data: categories
      end

      desc 'find products under category'
      get 'categories/:id' do
        @category = Category.includes(:topic_image, [products: :image]).find(params[:id])
        category = present @category, with: API::Entities::CategoryProducts
        build_response code: 0, data: category
      end

      desc 'find single product'
      get 'products/:id' do
        @product = Product.includes(:image, :product_properties, [product_images: :image]).find(params[:id])
        product = present @product, with: API::Entities::Product
        build_response code: 0, data: product
      end

      desc 'get openid'
      params do
        requires :code, type: String
      end
      post '/token/achieve' do
        openid_message = User.get_openid(params[:code])
        if openid_message["errcode"]
          error!({code: 1, message: 'opendid获取错误'})
        else
          if @user = User.find_by(openid: openid_message["openid"])
            user_id = @user.id
          else
            @user = User.create(openid: openid_message["openid"])
            user_id = @user.id
          end
          token = User.generate_token
          cache(key: token, expires_in: 12.hours) do
            { openid_message: openid_message, user_id: user_id, scope: User::Level::Ordinary }
          end
          {token: token}
        end
      end

      desc 'verify token'
      params do 
        requires :token, type: String
      end
      post '/token/verify' do
        if Rails.cache.fetch(params[:token])
          {isValid: true}
        else
          {isValid: false}
        end
      end

      desc 'post user address'
      params do 
        requires :name, type: String
        requires :mobile, type: String
        requires :province, type: String
        requires :city, type: String
        requires :country, type: String
        requires :detail, type: String
      end
      post '/address' do
        cache = cache_value
        user_id = cache["user_id"]
        if cache["scope"] >= 16
          if @user = User.find(user_id)
            create_or_update_user(@user, user_id)
          else
            error!({code: 1, message: '数据库中不存在该用户'})
          end
        else
          error!({code: 1, message: '该用户无权限'})
        end
      end

      desc 'get user address'
      get 'user/address' do
        cache = cache_value
        user_id = cache["user_id"]
        if user = User.find(user_id)
          user_address = user.user_address
          user_address = present user_address, with: API::Entities::UserAddress
        else
          error!({code: 1, message: '用户不存在'})
        end
      end


      desc 'post user order'
      post '/order' do
        cache = cache_value
        user_id = cache["user_id"]
        validate_create_order(params["products"], user_id)
      end
    end
  end
end
