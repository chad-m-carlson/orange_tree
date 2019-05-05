class OrangeTree
  def initialize
    @height = rand(0.0..4).round(2)
    @oranges = 0
    @picked_oranges = 0
    @age = 0
    @time = 0
    @tree_fertilizer = rand(1..9)
    @user_fertilizer = rand(3..7)
    @water = rand(1..9)
    @cash = rand(0.0..10).round(2)
    @sold_oranges = 0
    @total_oranges = 0
    puts "Congratulations for planting your new Orange Tree, it is currently #{@height} foot tall but doesn't have any oranges on it yet."
    puts "Perhaps you need to fertilize, water, or just pass some time and wait for it to get a bit older to start producing fruit."
    puts
    puts "Be careful not to over water or fertilize your tree, you could kill it!"
    puts "-Watering applies 3 units of water each time."
    puts "-You can apply any quantity of fertilizer as long as you have it in your inventory. Buy more fertilizer by visiting the store."
    puts "-Sell oranges to make money and buy more fertilizer in the store."
    puts "-Each trip to the store takes 1 month time."
    puts "-You currently have #{@user_fertilizer} fertilizer available."
    puts "-You have $#{@cash} available"
    puts "-The max water or fertilizer your tree can handle is 10. Your tree currently has #{@tree_fertilizer} fertilizer and #{@water} water."
    puts
    puts "-One year is equal to 12 months. Every action acrues a certain amount of time"
    puts "-Make sure to pick all your oranges each year! Oranges not picked by the end of the year fall off and you are unable to sell them."
    puts
    user_selection
  end

  def user_selection
    menu
    choice = gets.chomp.to_i
    case choice
    when 1
      seperator
      pick_oranges
    when 2
      seperator
      fertilize
    when 3
      seperator
      water
    when 4
      seperator
      inventory
    when 5
      seperator
      store
    when 6
      seperator
      time = rand(1..6)
      puts "#{time} months have passed."
      time_passes time
    when 7
      seperator
      exit
    end
    user_selection
  end

  def menu
    puts "1) Pick Oranges"
    puts "2) Fertilize your tree"
    puts "3) Water Your Tree"
    puts "4) Inventory"
    puts "5) Go to the store"
    puts "6) Pass time"
    puts "7) Exit"
  end

  def pick_oranges
    time = rand(1..3)
    if @oranges < 1
      puts "There are no oranges to pick!"
      seperator
    else
      picked = rand(1..@oranges)
      @oranges -= picked
      @picked_oranges += picked
      puts "It took you #{time} months to pick #{picked} oranges and they are now in your basket."
      time_passes time
      seperator
    end
  end

  def fertilize 
    puts "How much fertilizer would you like to use?"
    amount = gets.chomp.to_i
    if amount > @user_fertilizer
      puts "You don't have that much fertilizer"
      fertilize
      seperator
      return
    end
    if amount == 0
      user_selection
    end
    growth = rand().round(1)
    new_oranges = 0
    @height += growth
    @tree_fertilizer += amount
    @user_fertilizer -= amount
    time_passes 2 #rand().round(1)
    if tree_dies?
      puts "OOPS! You over fertilized your tree and it died!! So Sad :("
      death_summary
      puts "X" * 100
      exit
    end
    if @age > 1
      new_oranges = rand(0..5)
      @oranges += new_oranges
    end
    puts "Your tree grew #{growth} feet and produced #{new_oranges} oranges after fertilizing it!"
    seperator
  end
  
  def water
    growth = rand().round(1)
    new_oranges = 0
    @height += growth
    @water += 3
    time_passes 2
    if tree_dies?
      puts "OOPS! You over watered your tree and it died!! So Sad :("
      death_summary
      puts "X" * 100
      exit
    end
    if @age > 1
      new_oranges = rand(0..4)
      @oranges += new_oranges
    end
    puts "Your tree grew #{growth} feet and produced #{new_oranges} oranges after watering it!"
    seperator
  end
  
  def inventory
    puts "Fertilizer available = #{@user_fertilizer}"
    puts "Tree Fertilizer = #{@tree_fertilizer}"
    puts "Tree Water = #{@water}"
    puts "Oranges on tree = #{@oranges}"
    puts "Oranges in basket = #{@picked_oranges}"
    puts "Money = $#{@cash.round(2)}"
    seperator
  end

  def store
    puts "Welcome to the store, You can purchase fertilizer or sell oranges."
    puts "1) Purchase Fertilizer"
    puts "2) Sell Oranges"
    choice = gets.chomp.to_i
    case choice
    when 1
      seperator
      purchase_fertilizer
    when 2
      seperator
      sell_oranges
    end
    time_passes 1
  end
  def purchase_fertilizer
    price = rand(0.0..2.0).round(2)
    puts "The price for fertilizer is currently $#{price}. How much would you like to buy?"
    amount = gets.chomp.to_i
    if (amount * price) > @cash
      puts "You don't have enough money to buy that much fertilizer"
      purchase_fertilizer
      seperator
    end
    @user_fertilizer += amount
    @cash -= (amount * price)
    puts "Thank you for your purchase of #{amount} for a total of $#{amount * price}. You now have #{@user_fertilizer} fertilizer to use and $#{@cash.round(2)} left"
    seperator
  end

  def sell_oranges
    price = rand(0.0..3.0).round(2)
    puts "You currently have #{@picked_oranges} oranges, and the market price is $#{price}. How many would you like to sell?"
    amount_to_sell = gets.to_i
    if amount_to_sell > @picked_oranges
      puts "You cannot sell more Oranges than are in your basket"
      sell_oranges
    end
    sale_value = amount_to_sell * price
    @cash += sale_value
    @picked_oranges -= amount_to_sell
    @sold_oranges += amount_to_sell
    puts "You made $#{sale_value.round(2)} and currently have $#{@cash.round(2)} in your wallet."
    seperator
  end

  private

  def height
    if @tree_fertilizer <= 1
      puts "Your tree didn't grow this year because it is out of fertilizer"
      seperator
      return
    end
    if @water <= 1
      puts "Your tree didn't grow this year because it doesn't have enough 
      water"
      seperator
      return
    end
    if @age > 1 and @age < 4
      @height += rand(1..4)
    elsif @age >= 4 and @age < 6
      @height += rand(4..6)
    elsif @age >= 6 and @age < 8
      @height += rand(6..10)
    elsif @age >= 8
      @height += rand(1..4)
    end
  end

  def fruit_production
    oranges = 0
    if @tree_fertilizer <= 2
      puts "Your tree didn't produce any oranges this year due to lack of fertilizer"
      seperator
      return
    elsif @water <= 2
      puts "Your tree didn't produce any oranges this year due to lack of water"
      seperator
      # return
    end
    if @age >= 1 and @age < 4
      oranges += rand(1..3)
    elsif @age >= 4 and @age < 6
      oranges += rand(1..5)
    elsif @age >= 6 and @age < 8
      oranges += rand(3..10)
    elsif @age >= 8
      oranges += rand(7..15)
    end
    case @height
    when 4..10
      oranges += rand(3..5)
    when 11..20
      oranges += rand(10..20)
    when 21..30
      oranges += rand(20..30)
    when 31..10000
      oranges += rand(30..50)
    end
    @oranges += oranges
    @total_oranges += oranges
    oranges = 0
  end

  def time_passes amount
    month = {0 => 'January', 1 => 'January', 2 => 'Feburary', 3 => 'March', 4 => 'April', 5 => 'May', 6 => 'June', 7 => 'July', 8 => 'August', 9 => 'September', 10 => 'October', 11 => 'November', 12 => 'December'}
    @time += amount
    if hail_storm?
      if @oranges > 1
      x = rand(1..@oranges)
      @oranges -= x 
      puts "XXXXXX A hail storm came through and ruined #{x} oranges on your tree XXXXXX"
      end
    end
    if one_year_passes?
      @age += 1
      if tree_dies?
        death_summary
        seperator
        exit
      end
      @tree_fertilizer -= 2
      @water -= 2
      puts "Your tree lost #{@oranges} oranges, has #{@tree_fertilizer} fertilizer left and #{@water} water left."
      if @time > 12
        remainder = @time - 12
        @time = remainder
      else @time = 0
      end
      puts "It is currently #{month[@time]} of year #{@age}."
      @oranges = 0
      height
      fruit_production
      puts "Your tree survived another year, is #{@age} years old and is now #{@height.round(2)} feet tall with #{@oranges} oranges on it."
      seperator
    else 
      puts "The current month is #{month[@time]}"
      seperator
    end
  end


  def one_year_passes?
    @time >= 12
  end

  def tree_dies?
    @death = rand(8..20)
    @age >= @death or @tree_fertilizer > 10 or @tree_fertilizer == 0 or @water > 10 or @water == 0 #or @height > 100
  end

  def death_summary
    #PUT WHY THE TREE DIED AND OTHER STATS IN HERE
    if @age >= @death 
      puts "Your tree died of natural causes. It was #{@age} years old."
    elsif  @tree_fertilizer < 1
      puts "Your tree ran out of fertilizer"
    elsif @water < 1
      puts "Your tree ran out of water"
    end
    puts "-Height = #{@height.round(2)}"
    puts "-Fertilizer = #{@tree_fertilizer}"
    puts "-Water = #{@water}"
    puts "-Total oranges grown = #{@total_oranges}"
    puts "-Oranges sold = #{@sold_oranges}"
    puts "-Money = $#{@cash.round(2)}"
  end

  def seperator
    puts "*"*100
  end

  def hail_storm?
    rand(0..1).odd?
  end
end

tree = OrangeTree.new



