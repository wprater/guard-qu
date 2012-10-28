require 'spec_helper'

describe Guard::Qu do
  describe 'start' do

    it 'should accept :environment option' do
      environment = :foo

      obj = Guard::Qu.new [], :environment => environment
      obj.send(:env).should include 'RACK_ENV' => environment.to_s
    end

    it 'should accept :queue option' do
      queue = :foo

      obj = Guard::Qu.new [], :queue => queue
      obj.send(:env).should include 'QUEUE' => queue.to_s
    end

    it 'should accept :trace option' do
      obj = Guard::Qu.new [], :trace => true
      obj.send(:cmd).should include '--trace'
    end

    it 'should accept :task option' do
      task = 'environment foo'

      obj = Guard::Qu.new [], :task => task
      obj.send(:cmd).should include task
      obj.send(:cmd).should_not include Guard::Qu::DEFAULT_TASK
    end

    it 'should provide default options' do
      obj = Guard::Qu.new []
      obj.send(:env).should include 'QUEUE' => Guard::Qu::DEFAULT_QUEUE.to_s
      obj.send(:cmd).should include Guard::Qu::DEFAULT_TASK
    end

  end
end
