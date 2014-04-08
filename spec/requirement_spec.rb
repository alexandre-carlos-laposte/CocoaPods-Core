require File.expand_path('../spec_helper', __FILE__)

module Pod
  describe Requirement do
    describe 'In general' do

      it 'can be initialized with a string' do
        subject = Requirement.new('<= 1.0')
        subject.to_s.should == '<= 1.0'
      end

      it 'defaults to the equality operator on initialization' do
        subject = Requirement.new('1.0')
        subject.to_s.should == '= 1.0'
      end

      it 'can be initialized with an array of versions' do
        subject = Requirement.new([Version.new('1.0'), Version.new('2.0')])
        subject.to_s.should == '= 1.0, = 2.0'
      end

      it 'can be initialized with a pre-release version' do
        subject = Requirement.new(Version.new('1.0-beta'))
        subject.to_s.should == '= 1.0-beta'
      end

      it 'raises if initialized with an invalid input' do
        should.raise ArgumentError do
          Requirement.new(Version.new('1.0!beta'))
        end
      end

      it 'returns the default requirement' do
        Requirement.default.to_s.should == '>= 0'
      end

    end

    #-------------------------------------------------------------------------#

    describe 'Create factory method' do

      it 'can be created with a requirement' do
        req = Requirement.new('<= 1.0')
        subject = Requirement.create(req)
        subject.should == req
      end

      it 'can be created with a version' do
        subject = Requirement.create(Version.new('1.0'))
        subject.to_s.should == '= 1.0'
      end

      it 'can be created with an array of versions' do
        subject = Requirement.create([Version.new('1.0'), Version.new('2.0')])
        subject.to_s.should == '= 1.0, = 2.0'
      end

      it 'can be created with a string' do
        subject = Requirement.create('1.0')
        subject.to_s.should == '= 1.0'
      end

      it 'can be created with a nil input' do
        subject = Requirement.create(nil)
        subject.to_s.should == '>= 0'
      end

    end

    #-------------------------------------------------------------------------#

  end
end
