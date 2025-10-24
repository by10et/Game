extends Node

var database : SQLite


func _ready() -> void:
	
	var src_path = "res://data.db"
	var dest_path = "user://data.db"
	
	#DirAccess.remove_absolute(ProjectSettings.globalize_path((dest_path)))
	
	# 1️⃣ Dosya user://da var mı kontrol et
	if not FileAccess.file_exists(dest_path):
		# Dosya yok → kopyala
		var src_file = FileAccess.open(src_path, FileAccess.READ)
		if src_file == null:
			print("Kaynak database açılamadı!")
			return
		var data = src_file.get_buffer(src_file.get_length())
		src_file.close()
		
		# Hedef dosyaya yaz
		var dest_file = FileAccess.open(dest_path, FileAccess.WRITE) # Bu noktada dosya açılıyor
		if dest_file == null:
			print("Hedef dosya açılamadı!")
			return
		dest_file.store_buffer(data)
		dest_file.close()
		print("Database user://a güvenli şekilde kopyalandı")
	else:
		print("Database zaten var, kopyalama yapılmadı")
		
	database = SQLite.new()
	database.path = dest_path
	database.open_db()
	database.query("Select * From CHARACTER")
	var datA = database.query_result
	print(datA)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
