# typed: true
class Figure
    def initialize(name,startDirection,endDirection,style,dance,startPosition,endPosition,timing,startFoot,endFoot,level,startMomentum,endMomentum,xdisp,ydisp)
      @name = name
      @startDirection = startDirection
      @endDirection = endDirection
      @style = style
      @dance = dance
      @startPosition = startPosition
      @endPosition = endPosition
      @timing = timing
      @startFoot = startFoot
      @endFoot = endFoot
      @level = level
      @startMomentum = startMomentum
      @endMomentum= endMomentum
      @xdisp = xdisp
      @ydisp = ydisp
    end

    def data
      return data = {'name':@name,
      'startDirection':@startDirection,
      'endDirection':@endDirection,
      'style':@style,
      'dance':@dance,
      'startPosition':@startPosition,
      'endPosition':@endPosition,
      'timing':@timing,
      'startFoot':@startFoot,
      'endFoot':@endFoot,
      'level':@level,
      'startMomentum':@startMomentum,
      'endMomentum':@endMomentum,
      'xdisp':@xdisp,
      'ydisp':@ydisp
    }
    end
    def to_s
      @name + " (" + @endDirection + ")"
    end
end

class Routine

  def initialize(style, dance, floorDim, level, dancerSpec, startPosition, startWall, startDirection)
    @style = style
    @dance = dance
    @floorDim = floorDim
    @level = level
    @dancerSpec = dancerSpec
    @startPosition = startPosition
    @startWall = startWall
    @startDirection = startDirection
    @figureArray = []
    @totalDistance = [0,floorDim[1]/2]
    @currentPosition = nil
    @currentDirection = nil
    @lastFigure = nil
    @startCount = 1
    @endCount = nil
    @figureDB = {}
  end

  def readFigures()
    file = open('figures.csv')
    figures = file.readlines
    #Build @figureDB
    for line in figures
      if line.start_with?"#"
        next
      end
      name, startDirection, endDirection, style, dance, startPosition, endPosition, timing, startFoot, endFoot, level, startMomentum, endMomentum, xdisp, ydisp = line.split','
      figure = Figure.new(name.to_s.strip, startDirection.to_s.strip, endDirection.to_s.strip, style.to_s.strip, dance.to_s.strip, startPosition.to_s.strip, endPosition.to_s.strip, timing.to_s.strip, startFoot.to_s.strip, endFoot.to_s.strip, level.to_s.strip, startMomentum.to_s.strip, endMomentum.to_s.strip, xdisp.to_f, ydisp.to_f)
      fig_data = figure.data
      if !@figureDB.has_key?(fig_data[:level])
        @figureDB[fig_data[:level]] = {}
      end
      if !@figureDB[fig_data[:level]].has_key?(fig_data[:style])
        @figureDB[fig_data[:level]][fig_data[:style]] = {}
      end
      if !@figureDB[fig_data[:level]][fig_data[:style]].has_key?(fig_data[:dance])
        @figureDB[fig_data[:level]][fig_data[:style]][fig_data[:dance]] = []
      end
      @figureDB[fig_data[:level]][fig_data[:style]][fig_data[:dance]].push figure
    end
  end
  def figureDB
    @figureDB
  end

  def generateWall(wall)
    #floorDim is a [legth,width] of the floor
    rand = Random.new
    fig_list = @figureDB[@level][@style][@dance]
    while @totalDistance[0] < @floorDim[0]
      nextOption = fig_list[rand.rand(fig_list.length)]
      if @lastFigure != nil
        lastFigureData = @lastFigure.data
        nextOptionData = nextOption.data
        if lastFigureData[:endDirection] == nextOptionData[:startDirection] and lastFigureData[:endPosition] == nextOptionData[:startPosition] and lastFigureData[:endFoot] == nextOptionData[:startFoot] and (@totalDistance[1] + nextOptionData[:ydisp]) < @floorDim[1] and (@totalDistance[1] + nextOptionData[:ydisp]) > 0 and lastFigureData[:endMomentum] == nextOptionData[:startMomentum]
          @figureArray.append(nextOption)
          @totalDistance[0] += nextOptionData[:xdisp]
          @totalDistance[1] += nextOptionData[:ydisp]
          @lastFigure = nextOption
          
        end
      else
        nextOptionData = nextOption.data
        if @startDirection == nextOptionData[:startDirection] and @startPosition == nextOptionData[:startPosition]
          @figureArray.append(nextOption)
          @totalDistance[0] += nextOptionData[:xdisp]
          @totalDistance[1] += nextOptionData[:ydisp]
          @lastFigure = nextOption
          
        end
      end
    end
    return @figureArray
  end

  def generate()
    wall1 = self.generateWall(@startWall)
    puts @style + " " + @dance
    puts @startWall + " wall:"
    puts wall1
  end


end

r = Routine.new("STD","WALTZ",[10,10],"N",1,"I","Long","DW")
r.readFigures
#puts r.figureDB['N']["STD"]
d = r.figureDB['N']["STD"]["WALTZ"]
#for el in d
  #puts el.to_s
#end

r.generate()
