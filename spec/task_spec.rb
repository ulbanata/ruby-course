require 'spec_helper.rb'

describe TM::Task do

  it "should exist" do
    expect(TM::Task).to be_a(Class)
  end

  describe "#initialize" do
    it "should initialize with a project id, id, description, priority_num" do
      task = TM::Task.new(1, "A task", 3)
      expect(task.desc).to eq("A task")
      expect(task.proj_id).to eq(1)
      expect(task.priority_num).to eq(3)
      expect(task.complete).to be_false
      expect(task.id).to be_a(Integer)
      expect(task.creation).to be_a(Time)
    end
  end

  describe "#mark_complete" do
    it "should mark the task complete" do
      task = TM::Task.new(1, "A task", 3)
      expect(task.complete).to be_false
      task.mark_complete
      expect(task.complete).to be_true
    end
  end
end
