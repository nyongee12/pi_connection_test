class HomeController < ApplicationController
  $get_next = false
  def index
    if params[:cont] == "true"
      $get_next = true
    else
      $get_next = false
    end
    client = CloudscrapeClient.new
    execution_id = client.runs("42a3ff51-370b-4b35-a3ba-de1aa1031408").execute
    while
      execution = client.executions(execution_id).get
      break if execution.ok?
    end
    execution = client.executions(execution_id).result
    @result = get_result(execution.as_hash)
    client.executions(execution_id).remove
  end

  def get_result(result)
    text = result["status"].split("<span")
    tmp = text[2]+text[3]+text[4]+text[5]
    tmp1 = tmp.split("</span>")
    tmp1.pop
    tmp2 = tmp1.join.split(">")
    status = []
    tmp2.each_with_index do |p, idx|
      if idx%2 == 1
        status << p.split(" ")[0]
      end
    end
    return status
  end
#  def index
#    require 'open-uri'
    
#    @doc = Nokogiri::HTML(open("https://developer.weaved.com/portal/members/home.php"))
#    @first = @doc.css('table#t2 > tr > td#n0 > font')
#  end
#  def index
#    require 'net/http'

#    http = Net::HTTP.new('52.193.108.30',80)
#    response = http.request_get('/')
#    $status = response.code
#  end
#  def index
#    require 'timeout'
#    require 'socket'

#    def ping(host)
#      begin
#        Timeout.timeout(5) do 
#          s = TCPSocket.new(host, 'echo')
#          s.close
#          return true
#        end
#      rescue Errno::ECONNREFUSED 
#        return true
#      rescue Timeout::Error, Errno::ENETUNREACH, Errno::EHOSTUNREACH
#        return false
#      end
#    end

#    $status = ping('www.google.com')
#  end
#end
end

