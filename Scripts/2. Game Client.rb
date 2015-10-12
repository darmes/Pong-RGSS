require "socket"
# GameClient needs to get player 1 paddle position and ball position
# GameClient needs to send player 2 paddle position
# Get message format: 000,000;000,000; # paddle_x,paddle_y;ball_x,ball_y
# Send message format: 000,000; # paddle_x,paddle_y
class GameClient

	include Mobius::Multiplayer

	# default port = 1990
	# default hostname = localhost
	def initialize(port = DEFAULT_PORT, hostname = DEFAULT_HOSTNAME)
		@socket = TCPSocket.new(hostname, port)
		@request = ""
		@reply = ""
	end
	
	def send_message(msg)
		Console.log("sending message: #{msg}...\n")
		@request = msg.ljust(16).slice(0,15)
		@socket.send(@request, 0)
		Console.log("message sent\n")
	end
	
	def get_reply
		Console.log("waiting for reply...\n")
		thr = Thread.new do
			@reply = @socket.recv(16).rstrip
		end
		# wait up to 2 seconds for response
		if thr.join(2)
			Console.log("reply received: #{@reply}\n")
			return @reply
		else
			thr.kill
			Console.log("no reply received")
			return nil
		end
	end
	
	# arr = [paddle_x,paddle_y,ball_x,ball_y]
	# convert to "000,000,000,000,"
	def pack_message(arr)
		return arr.collect {|x| sprintf("%03d", x)}.join(",") + ","
	end
	
	# str = "000,000,000,000,"
	# convert to [paddle_x,paddle_y,ball_x,ball_y]
	def unpack_message(str)
		return str.split(",").collect {|x| x.to_i}
	end
	
	def send_test
		send_message "000,000,000,000,"
	end
	
	def send_paddle(paddle_x, paddle_y)
		temp_arr = [paddle_x, paddle_y, 0, 0]
		new_message = pack_message(temp_arr)
		send_message(new_message)
	end
	# returns [paddle_x,paddle_y]
	def get_paddle()
		if get_reply
			temp_arr = unpack_message(@reply)
			# remove last two entires
			return temp_arr.pop.pop
		else
			return nil
		end
	end
	
	def send_paddle_and_ball(paddle_x, paddle_y, ball_x, ball_y)
		temp_arr = [paddle_x,paddle_y,ball_x,ball_y]
		new_message = pack_message(temp_arr)
		send_message(new_message)
	end
	# returns [paddle_x,paddle_y,ball_x,ball_y]
	def get_paddle_and_ball()
		if get_reply
			return unpack_message(@reply)
		else
			return nil
		end
	end
end