class TestJob
  include Sidekiq::Job

  def perform(complexity)
    case complexity
    when "super_hard"
      sleep 20
      Rails.logger.info "That was super hard!"
    when "hard"
      sleep 10
      Rails.logger.info "That was hard!"
    else
      sleep 1
      Rails.logger.info "That was easy!"
    end
  end
end
