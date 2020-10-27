require "pry"

class Application
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
    if req.path.match(/items/)
      item_name = req.path.split("/").last #turn /songs/Sorry into Sorry
      item = Item.all.select { |i| i.name == item_name }.first
      if item
        resp.write item.price
        resp.finish
      else
        resp.write "Item not found"
        resp.status = 400
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end

    resp.finish
  end
end
