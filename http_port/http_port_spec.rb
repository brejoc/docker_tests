require 'docker'
require 'net/http'


describe "the mmcken/nginx image" do
    before(:all) {
        @image = Docker::Image.all().detect{|i| i.info['RepoTags'][0] == 'mmckeen/nginx:latest'}
    }

    it "should be available" do
        expect(@image).to_not be_nil
    end

    it "should expose the default tcp port" do
        expect(@image.json["ContainerConfig"]["ExposedPorts"]).to include("80/tcp")
    end
end

describe "running mmcken/nginx as container" do
    before(:all) do
        @image = Docker::Image.all().detect{|i| i.info['RepoTags'][0] == 'mmckeen/nginx:latest'}
        id = `docker run -d -p 127.0.0.1:8080:80 #{@image.id}`.chomp
        @container = Docker::Container.get(id)
    end

    after(:all) do
        @container.kill
        @container.delete
    end

    it "should accept connections to port 80" do
        # Currently we don't really know when the container is really
        # started, so we'll just wait.
        # see: https://github.com/docker/docker/issues/7445
        result = nil
        (0..15).each do
            begin
                result = Net::HTTP.get(URI.parse('http://127.0.0.1:8080'))
                break if result.is_a? String
            rescue
                # waiting for webserver to start…
            end
            sleep(2)
        end
        expect(result).to be_an_instance_of(String)
        # or better use something that also uses http status codes
    end
end
