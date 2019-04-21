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
            if token = request.headers["Weixin-Token"]
              if JSON.parse(Rails.cache.fetch(token))
                cache = JSON.parse(Rails.cache.fetch(token))
              else
                error!({code: 1, message: '缓存中不存在该token'})
              end
            else
              error!({code: 1, message: 'header中未传递token'})
            end
          end

          def create_or_update_user(user, user_id)
            if user.user_address
              user.user_address.update(name: params[:name], mobile: params[:mobile], province: params[:province], city: params[:city], country: params[:country])
            else
              user.create_user_address(name: params[:name], mobile: params[:mobile], province: params[:province], city: params[:city], country: params[:country])
            end
            build_response code: 0, data: user.user_address
          end

          def validate_create_order(products, user_id)
             #查看库存是否满足要求
             order_product_ids = []
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

             #创建订单
             stock_products = Product.find(order_product_ids).pluck(:id, :price)
             total_price = 0
             order_products.each_index do |index|
               total_price += order_products[index]["count"]*stock_products[index][1]
             end
             order = Order.create(user_id: user_id, total_price: total_price)
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
