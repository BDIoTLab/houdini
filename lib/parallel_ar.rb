require 'parallel'

module ParallelAr

  def self.reduce(arr, accum, &block)
    Parallel.each(arr, in_threads: 8) do |elem|
      ActiveRecord::Base.connection_pool.with_connection do
        ActiveRecord::Base.transaction do
          accum = block.call(accum, elem)
        end
      end
    end
    return accum
  end

end
