require 'laying_hen'

describe Egg do
  # Egg tests here

  let(:hatched_hours) {2}
  let(:egg) {Egg.new(hatched_hours)}

  describe "#initialize" do
    context "with valid input" do
      it "creates a new Egg" do
        expect(egg).to be_an_instance_of Egg
      end
    end

    context "with invalid input" do
      it "throws an error if Egg doesn't have hatched hours" do
        expect{Egg.new()}.to raise_error(ArgumentError)
      end
    end
  end

  describe "#rotten?" do
    context "with no rotten eggs" do
      it "rotten is false" do
        expect(egg.rotten?).to eq(false)
      end
    end

    context "with rotten eggs" do
      it "rotten is true" do
        expect(Egg.new(4).rotten?).to eq(true)
      end
    end
  end
end

describe LayingHen do
  # LayingHen tests here
  let(:hen) {LayingHen.new()}

  describe "#initialize" do
    context "with valid input" do
      it "creates a new LayingHen" do
        expect(hen).to be_an_instance_of LayingHen
      end
    end

    context "with invalid input" do
      it "throws an error if Egg doesn't have hatched hours" do
        expect{LayingHen.new(1)}.to raise_error(ArgumentError)
      end
    end
  end

  describe "#age" do
    it "reads the initial age" do
      expect(hen.age).to eq(0)
    end
  end  

  describe "#age!" do
    it "increase hen's age" do
      hen.age!
      expect(hen.age).to eq(1)      
    end
  end

  describe "#any_eggs?" do
    context "with no eggs" do
      it "doesn't have any egg" do
        expect(hen.any_eggs?).to eq(false) 
      end
    end

    context "with eggs" do
      it "puts 4 eggs" do
        4.times { hen.age! }
        expect(hen.any_eggs?).to eq(true)        
      end
    end    
  end

  describe "#old?" do
    context "hen with 0 months" do
      it "hen is young" do
        expect(hen.old?).to eq(false)
      end      
    end

     context "old hen" do
      it "hen is old" do
        11.times { hen.age! }
        expect(hen.old?).to eq(true)
      end      
     end
  end

  describe "#increase_hatched_hour" do
    context "with valid integer input" do
      it "increase hours" do
        expect(hen.increase_hatched_hour(2)).to eq(2)
      end
    end

    context "with invalid no intenger input" do
      it "throws an error if input doesn't is a integer" do
        expect{hen.increase_hatched_hour('hola')}.to raise_error(ArgumentError)
      end
    end
  end

  describe "#pick_an_egg!" do
    context "with no error (with hen with eggs)" do
      it "creates a egg" do
        4.times { hen.age!}
        hen.increase_hatched_hour(2)
        expect(hen.pick_an_egg!).to be_kind_of(Egg)
      end
    end

    context "with error" do
      it "throws an error if hen doesn't have eggs" do
        expect{hen.pick_an_egg!}.to raise_error(NoEggsError)
      end
    end
  end
  
end  