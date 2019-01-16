# frozen_string_literal: true

require "socket"
require "influxdb"

class TelegrafAgent
  ConnectionError = Class.new(StandardError)

  attr_reader :uri, :logger

  # Initialize an agent
  #
  # @param [Hash] opts
  # @option opts [String] :url URL
  # @option opts [#debug] :logger Logger
  def initialize(url:, logger: nil)
    @uri = URI.parse(url)
    @logger = logger
  end

  # Send data to telegraf
  #
  # @param [String] series Series name
  # @param [Hash] opts
  # @option opts [Hash] :tags Tags
  # @option opts [Hash] :values Values
  def write(series, tags:, values:)
    data = ::InfluxDB::PointValue.new(series: series, tags: tags, values: values).dump
    logger&.debug("Sending data to #{uri}: #{data}")
    connection.write(data)
  rescue
    disconnect!
  end

  private

  def disconnect!
    connection&.close
    @connection = nil
  end

  def connection
    @connection ||= create_connection!
  end

  def create_connection!
    case uri.scheme.downcase
    when "unix"
      Socket.new(:UNIX, :STREAM).tap { |socket| socket.connect(Socket.pack_sockaddr_un(uri.path)) }
    when "unixgram"
      Socket.new(:UNIX, :DGRAM).tap { |socket| socket.connect(Socket.pack_sockaddr_un(uri.path)) }
    when /^tcp/
      TCPSocket.new(uri.host, uri.port)
    when /^udp/
      UDPSocket.new.tap { |socket| socket.connect(uri.host, uri.port) }
    else
      raise ConnectionError, "Unsupported connection type: #{uri.scheme}"
    end
  end
end
