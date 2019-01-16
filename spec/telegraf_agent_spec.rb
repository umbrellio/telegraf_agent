# frozen_string_literal: true

RSpec.describe TelegrafAgent do
  shared_examples "data sender" do |url|
    subject(:write!) { agent.write(*write_data) }

    let(:agent) { described_class.new(url: url, logger: logger) }
    let(:expected_log_message) { "Sending data to #{url}: some-data,tag=123 a=1i" }
    let(:logger) { instance_double(Logger, debug: nil) }
    let(:write_data) { ["some-data", { values: { a: 1 }, tags: { tag: 123 } }] }

    it "sends data to socket" do
      expect(logger).to receive(:debug).with(expected_log_message)
      expect(socket_double).to receive(:write).once.with("some-data,tag=123 a=1i")
      expect(socket_double).to receive(:connect).once if socket_double.respond_to?(:connect)
      write!
    end

    context "when writing raises an error" do
      before { allow(socket_double).to receive(:write).and_raise(NoMethodError) }

      it "close a connection" do
        expect(socket_double).to receive(:close)
        write!
      end
    end
  end

  context "udp" do
    let(:socket_double) { instance_double(UDPSocket, connect: nil, write: nil, close: nil) }

    before { stub_const("UDPSocket", double(new: socket_double)) }

    it_behaves_like "data sender", "udp://localhost:1010"
  end

  context "tcp" do
    let(:socket_double) { instance_double(TCPSocket, write: nil, close: nil) }

    before { stub_const("TCPSocket", double(new: socket_double)) }

    it_behaves_like "data sender", "tcp://localhost:1010"
  end

  context "unix" do
    let(:socket_double) { instance_double(Socket, connect: nil, write: nil, close: nil) }

    before { stub_const("Socket", double(new: socket_double)) }

    before { allow(Socket).to receive(:pack_sockaddr_un).and_return("/socket/path") }

    it_behaves_like "data sender", "unix://etc/socket/path"
  end
end
