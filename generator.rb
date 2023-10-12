# typed: true
class Figure
    def initialize(name,startDirection,endDirection,style,dance,endPosition,timing,startFoot,endFoot,level)
      @name = name
      @startDirection = startDirection
      @endDirection = endDirection
      @style = style
      @dance = dance
      @endPosition = endPosition
      @timing = timing
      @startFoot = startFoot
      @endFoot = endFoot
      @level = level
    end

    def data
      return data = {'name':@name,
      'startDirection':@startDirection,
      'endDirection':@endDirection,
      'style':@style,
      'dance':@dance,
      'endPosition':@endPosition,
      'timing':@timing,
      'startFoot':@startFoot,
      'endFoot':@endFoot,
      'level':@level}
    end
    def to_s
      out = ''
      d = self.data
      for i in d.keys
        out += i.to_s + ":" + d[i] + ', '
      end
      return out
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
    @totalDistance = nil
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
      name, startDirection, endDirection, style, dance, endPosition, timing, startFoot, endFoot, level = line.split','
      figure = Figure.new(name.to_s.strip, startDirection.to_s.strip, endDirection.to_s.strip, style.to_s.strip, dance.to_s.strip, endPosition.to_s.strip, timing.to_s.strip, startFoot.to_s.strip, endFoot.to_s.strip, level.to_s.strip)
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
    while @totalDistance < @floorDim[0]

    end
  end

  def generate()
    wall1 = generateWall(@startWall)
  end


end

r = Routine.new("STD","WATLZ",[10,10],"N",1,"I","Long","DW")
r.readFigures
#puts r.figureDB['N']["STD"]
d = r.figureDB['N']["STD"]["WALTZ"]
for el in d
  puts el.to_s
end
