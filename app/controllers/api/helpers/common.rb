module API
  module Helpers
    module Common
      extend ActiveSupport::Concern

      included do
        helpers do
          def build_response code: 0, data: nil
            { code: code, data: data }
          end

          def cache_value
            if token = request.headers["Token"]
              if Rails.cache.fetch(token)
                cache = JSON.parse(Rails.cache.fetch(token))
              else
                error!({code: 1, message: '缓存中不存在该token'}, 401)
              end
            else
              error!({code: 1, message: 'header中未传递token'}, 401)
            end
          end

          def create_or_update_user(user, user_id)
            if user.user_address
              user.user_address.update(name: params[:name], mobile: params[:mobile], province: params[:province], city: params[:city], country: params[:country], detail: params[:detail])
            else
              user.create_user_address(name: params[:name], mobile: params[:mobile], province: params[:province], city: params[:city], country: params[:country], detail: params[:detail])
            end
            build_response code: 0, data: user.user_address
          end

          def validate_order(products, user_id)
             #查看库存是否满足要求
             order_product_ids = []
             #order_products是订单传递过来的数据, stock_products是数据库中查询的数据
             order_products = products
             status = true
             products.each do |product|
               order_product_ids << product["product_id"]
             end
             unless stock_products = Product.find(order_product_ids).pluck(:id, :stock)
               error!({code: 1, message: '不存在该商品'})
             end
             order_products.each_index do |index|
               if (order_products[index]["product_id"] != stock_products[index][0]) || (order_products[index]["count"] > stock_products[index][1])
                 status = false
               end
             end
             unless status
               error!({code: 1, message: '商品无库存'})
             end
           end

          def create_order(products, user_id)
             #初始化参数
             order_product_ids = []
             order_products = products
             products.each do |product|
               order_product_ids << product["product_id"]
             end

             #创建订单
             stock_products = Product.find(order_product_ids).pluck(:id, :price)
             total_price = 0
             total_count = 0

             #计算总价
             order_products.each_index do |index|
               total_price += order_products[index]["count"]*stock_products[index][1]*100
             end
             total_price = total_price/100
             #计算总的订单数
             order_products.each do |product|
               total_count += product["count"]
             end

             #获得订单地址
             user_address = User.find(user_id).user_address
             if user_address
               #snap_address = user_address.province + user_address.city + user_address.country + user_address.detail
               snap_address = user_address.to_json(except: [:id, :user_id, :created_at, :updated_at])
             else
               error!({code: 1, message: '地址不存在'})
             end

             #获取snap_img和snap_name
             product = Product.find(order_products[0]["product_id"])
             if product
               snap_img = product.image.link
               snap_name = product.name
               if order_products.size > 1
                 snap_name = product.name + "等"
               else
                 snap_name = product.name
               end 
              else
               error!({code: 1, message: '商品不存在'})
             end

             #获取order_no
             order_no  = User.generate_order_uuid

             order = Order.create(user_id: user_id, total_price: total_price, total_count: total_count, snap_address: snap_address, snap_name: snap_name, snap_img: snap_img, order_no: order_no)
             order_products.each do |product|
               order.order_products.create(product_id: product["product_id"], count: product["count"])
             end
          end

          params :id_validator do
            requires :id, type: Integer
          end
        end
      end

    end
  end
end
