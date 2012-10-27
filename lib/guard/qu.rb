require 'guard'
require 'guard/guard'
require 'timeout'

module Guard
  class Qu < Guard

    DEFAULT_SIGNAL = :TERM
    DEFAULT_QUEUE = 'default'.freeze
    DEFAULT_TASK = 'qu:work'.freeze

    # Allowable options are:
    #  - :environment  e.g. 'test'
    #  - :task .e.g 'qu:work'
    #  - :queue e.g. 'failed'
    #  - :trace e.g. true
    #  - :stop_signal e.g. :QUIT or :SIGQUIT
    def initialize(watchers = [], options = {})
      @options = options
      @pid = nil
      @stop_signal = options[:stop_signal] || DEFAULT_SIGNAL
      @options[:queue] ||= DEFAULT_QUEUE
      @options[:task] ||= DEFAULT_TASK
      super
    end

    def start
      stop
      UI.info 'Starting up qu...'
      UI.info [ cmd, env.map{|v| v.join('=')} ].join(' ')

      # launch Qu worker
      @pid = spawn(env, cmd)
    end

    def stop
      if @pid
        UI.info 'Stopping qu...'
        ::Process.kill @stop_signal, @pid
        begin
          Timeout.timeout(15) do
            ::Process.wait @pid
          end
        rescue Timeout::Error
          UI.info 'Sending SIGKILL to qu, as it\'s taking too long to shutdown.'
          ::Process.kill :KILL, @pid
          ::Process.wait @pid
        end
        UI.info 'Stopped process qu'
      end
    rescue Errno::ESRCH
      UI.info 'Guard::Qu lost the Qu worker subprocess!'
    ensure
      @pid = nil
    end

    # Called on Ctrl-Z signal
    def reload
      UI.info 'Restarting qu...'
      restart
    end

    # Called on Ctrl-/ signal
    def run_all
      true
    end

    # Called on file(s) modifications
    def run_on_changes(paths)
      restart
    end

    def restart
      stop
      start
    end

    private

    def cmd
      command = ['bundle exec rake', @options[:task].to_s]

      # trace setting
      command << '--trace' if @options[:trace]

      return command.join(' ')
    end

    def env
      var = Hash.new

      var['QUEUE']     = @options[:queue].to_s       if @options[:queue]
      var['RACK_ENV']  = @options[:environment].to_s if @options[:environment]

      return var
    end
  end
end

