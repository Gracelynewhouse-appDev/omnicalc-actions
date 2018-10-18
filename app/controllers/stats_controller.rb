class StatsController < ApplicationController
  def stats
    @numbers = params.fetch("list_of_numbers").gsub(",", "").split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @numbers.max - @numbers.min

    # Median
    # ======
    
    c  = @count
    if c.odd? then
      m = @numbers[((c/2) + 1).to_i]
    else
      m = (@numbers[((c/2)-1).to_i]  + @numbers[(c/2).to_i])/2
    end
  
    @median = m

    @sum = @numbers.sum

    @mean = @numbers.sum / @numbers.count

    # Variance
    # ========
    m = @mean
    vars = []
    @numbers.each do |num|
      vars.push((m-num)**2)
    end
  
    v = vars.sum / @numbers.length
    std  = v ** 0.5
    @variance = v

    @standard_deviation = std

    # Mode
    # ====
    
    @mode = @numbers.group_by{|e| e}.max_by{|k, v| v.length}.first

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("stats_templates/stats.html.erb")
  end

  def stats_form
    render("stats_templates/stats_form.html.erb")
  end
  
end
