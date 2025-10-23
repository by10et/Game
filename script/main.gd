extends Control


@onready var hp_bar: TextureProgressBar = $CharacterBody2D2/HpBar
@onready var main_hp_bar: TextureProgressBar = $MainCharacter/HpBar
@onready var label_level: Label = $Label_level
@onready var label_name: Label = $Label_name
@onready var label_gold: Label = $Label_gold

var database : SQLite
var requestedXP:int = 50
var xp:int = 0

var hp:int
var strength:int
var defense:int
var cName:String
var level:int
var atkSpeed:int
var dodge:int
var crit:int
var critChance:int
var gold:int
var lifesteal:int
var accuracy:int
var intelligent:int

func _ready() -> void:
	
	var user_db_path = "user://data.db"
	var default_db_path = "res://data.db"
	
	
	DirAccess.remove_absolute(ProjectSettings.globalize_path((user_db_path)))
	
	
	if not FileAccess.file_exists(user_db_path):
		print("İlk açılış tespit edildi, örnek veritabanı kopyalanıyor...")
		var source = FileAccess.open(default_db_path, FileAccess.READ)
		var dest = FileAccess.open(user_db_path, FileAccess.WRITE)
		while not source.eof_reached():
			dest.store_buffer(source.get_buffer(1024)) # 1 KB parça parça
		source.close()
		dest.close()
		print("Kopyalama tamamlandı:", user_db_path)
	else:
		print("Mevcut veritabanı bulundu:", user_db_path)
		
		print("user path:",OS.get_user_data_dir())
		print(FileAccess.file_exists(user_db_path))
		
	database = SQLite.new()
	database.path = user_db_path
	database.open_db()
	
	_Load()
	
	label_level.text = "Lvl: " + str(level)
	label_name.text = cName
	label_gold.text = str(gold)
	

func _physics_process(delta: float) -> void:
	
	
	
	if $CharacterBody2D2.position.x <= $MainCharacter.position.x + 40:
		hp_bar.value -= strength * atkSpeed
		hp_bar.visible = true
	else:
		$CharacterBody2D2.position.x -= 180 * delta
	
	if hp_bar.value == 0:
		xp += 50
		if xp >= requestedXP:
			xp -= requestedXP
			level += 1
			label_level.text = "Lvl: " + str(level)
			requestedXP += 20
		
		hp_bar.value = 100
		$CharacterBody2D2.position.x = 1290
		hp_bar.visible = false
		
	
func _Save() -> void:
	pass

func _Load() -> void:#oyun açıldığında datayı çek
	database.query("Select * From Character")
	var data = database.query_result
	
	hp = data[0]["hp"]
	strength = data[0]["str"]
	defense = data[0]["def"]
	cName = data[0]["name"]
	level = data[0]["level"]
	atkSpeed = data[0]["atk_speed"]
	dodge = data[0]["dodge"]
	crit = data[0]["crit"]
	critChance = data[0]["crit_chance"]
	gold = data[0]["gold"]
	lifesteal = data[0]["lifesteal"]
	accuracy = data[0]["acc"]
	intelligent = data[0]["int"]
