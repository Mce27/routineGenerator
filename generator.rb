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
      data = {'name':@name,
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
end

class Routine
  @figureArray = []
  @totalDistance = nil
  @currentPosition = nil
  @currentDirection = nil
  @lastFigure = nil
  @startCount = 1
  @endCount = nil
  @figureDB = {}
  def initialize(style, dance, floorDim, level, dancerSpec, startPosition, startWall, startDirection)
    @style = style
    @dance = dance
    @floorDim = floorDim
    @level = level
    @dancerSpec = dancerSpec
    @startPosition = startPosition
    @startWall = startWall
    @startDirection = startDirection
  end

  def readFigures()
    file = open('figures.txt')
    figures = file.read
    figures = figures.split '\n'
    #Build @figureDB
    for line in figures
      name, startDirection, endDirection, style, dance, endPosition, timing, startFoot, endFoot, level = line.split','.strip
      figure = Figure.new(name, startDirection, endDirection, style, dance, endPosition, timing, startFoot, endFoot, level)
      fig_data = figure.data
      if !@figureDB.has_key?(fig_data[:level])
        @figureDB[level] = {}
      end
      if !@figureDB[level].has_key?(fig_data[:style])
        @figureDB[level][style] = {}
      end
      if !@figure[level][style].has_key?(fig_data[:dance])
        @figure[level][style][dance] = []
      end
      @figure[level][style][dance].push figure
    end
  end

  def generateWall(wall)
    #floorDim is a [legth,width] of the floor
    while totalDistance < floorDim[0]

    end
  end

  def generate()
    wall1 = generateWall(@startWall)
  end


end
