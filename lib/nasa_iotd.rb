require 'json'
require 'open-uri'
require 'pp'

class NASAIOTD

  def initialize
    @nodes = fetch_nodes
  end

  def today
    extend_download(fetch_node(@nodes.first))
  end

  private

  def fetch_nodes
    nodes = []
    url = 'http://www.nasa.gov/api/1/query/ubernodes.json?unType%5B%5D=image&routes%5B%5D=1446&page=0&pageSize=24'
    JSON.parse(open(url).read).fetch('ubernodes').each do |node|
      nodes.push(node.fetch('nid'))
    end

    nodes
  end

  def fetch_node(id)
    url = format('http://www.nasa.gov/api/1/record/node/%s.json', id)
    data = JSON.parse(open(url).read).fetch('images').first
    {node: id, fid: data['fid'], filename: data['filename'], uri: build_img_url(data['uri'])}
  end

  def build_img_url(uri)
    prefix = 'http://www.nasa.gov/sites/default/files/'
    uri.gsub(/^public:\/\//, prefix)
  end

  def extend_download(node)
    # Extend download method to node hash.
    class << node
      def download
        filename = "./images/#{self.fetch(:filename)}"
        return if File.exist?(filename)
        open(self.fetch(:uri)) do |img|
          File.open(filename, 'wb') { |file| file.puts img.read }
        end
      end
    end

    # Ensure to return node itself.
    node
  end

end