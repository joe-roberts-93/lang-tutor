require 'rails_helper'
RSpec.describe TestJob, type: :job do
  it "enqueues a job" do
    expect {
      TestJob.perform_later
    }.to have_enqueued_job
  end
  it "is in the default queue" do
    expect(TestJob.new.queue_name).to eq("default")
  end
end
