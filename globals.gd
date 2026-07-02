extends Node

var map: MapGen

var world_width: int = 32
var world_height: int = 32


var world: Dictionary = {}
var entities: Dictionary = {}

var peebo_instanciator: PeeboInstanciator

const DIRS := [
	Vector2i.LEFT,
	Vector2i.RIGHT,
	Vector2i.UP,
	Vector2i.DOWN
]


func is_occupied(pos: Vector2i) -> bool:
	return entities.has(pos)

func add_entity(pos: Vector2i, entity: Node2D):
	entities[pos] = entity

func remove_entity(pos: Vector2i):
	entities.erase(pos)

func set_tile(pos: Vector2i, ground: String):
	world[pos] = {
		"ground": ground,
	}

func get_tile(pos: Vector2i) -> Dictionary:
	return world.get(pos, {})

func get_ground(pos: Vector2i) -> String:
	return world.get(pos, {}).get("ground", "")

func get_object(pos: Vector2i) -> String:
	return world.get(pos, {}).get("object", "")

func has_object(pos: Vector2i) -> bool:
	return get_object(pos) != ""

func get_entity(pos: Vector2i):
	return entities.get(pos)

func get_neighbors_of_script(pos: Vector2i, script: Script) -> Array:
	var neighbors: Array = []

	for dir in DIRS:
		var entity = get_entity(pos + dir)

		if entity != null and entity.get_script() == script:
			neighbors.append(entity)

	return neighbors

#region Names
var names: Array[String] = [
	"Bibo",
	"Bocó",
	"Dido",
	"Bingus",
	"Ronaldo",
	"Tito",
	"Renatinha",
	"Lilo",
	"Lala",
	"Nina",
	"Thiago",
	"Wungas",
	"Gordinho",
	"Wayne",
	"Liam",
	"Jesse Pinkman",
	"Sérgio",
	"Barabarabara Bereberebere",
	"Mr. Fucks",
	"Nino",
	"Peebi",
	"Peeba",
	"Liuliu",
	"Bobis",
	"Pipoco",
	"Tonho",
	"Pipis",
	"Boboca",
	"Greg",
	"Totó",
	"Moranguinho",
	"Wawa",
	"Coco",
	"Edu",
	"Cat",
	"Vini Jr",
	"Querbt",
	"Walter White",
	"Edgar",
	"Red",
	"Telepio",
	"Yuyo",
	"Ungas",
	"Im Peebo",
	"OOOOOOOOOOOOOOOO",
	"Pu",
	"Anananana",
	"Sall",
	"Darren",
	"Fillbert",
	"Gal Costa",
	"Hugh",
	"Jo",
	"Kikikikikikikikik",
	"Lalo",
	"Zoroastro",
	"Cock",
	"Vlad",
	"Blad",
	"Nini",
	"Miumiu"
]
#endregion
