extends Sprite2D

func init(i):
	var rect =  get_rect().size*scale
	position.x += rect[0]*i
