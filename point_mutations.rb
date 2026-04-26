class DNA
  attr_reader :old

  def initialize(old_sequence)
    @old = old_sequence.chars
  end

  def hamming_distance(new)
    count = 0
    shorter = old.length < new.length ? old : new.chars
    longer = old.length < new.length ? new.chars : old

    shorter.each_with_index do |strand, index|
      if strand != longer[index]
        count += 1
      end
    end
    count
  end
end