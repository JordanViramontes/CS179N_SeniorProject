extends WeaponBase

# middle is hitscan, the hit detection will not be done with a hitscan script and not bullet.gd

@export var bullet_range: float = 1000.0 # long range! make this higher if you need it should be very high
@export var shoot_height_offset: float
var shadow: bool = false
var current_bullet: HitscanBullet
func _ready() -> void:
	super._ready()
	on_shoot.connect(on_on_shoot)
	on_ceasefire.connect(on_on_ceasefire)

func on_on_shoot(from_position: Vector3, look_direction: Vector3, velocity: Vector3):
	if bullet == null:
		print("middle.gd - set my bullet property bro! i dont have it!")
		
		
	if !shadow:
		var b = bullet.instantiate()
		
		
		if b == null: # just in case
			print("middle.gd - bullet did not instantiate")
			return
		current_bullet = b
		
			
	current_bullet.position = from_position
	current_bullet.tracer_origin = $BulletEmergePoint.global_position # is one meter ahead of the player, which lines up with the barrel of the weapon
	current_bullet.bullet_damage = bullet_damage
	current_bullet.distance = bullet_range
	current_bullet.direction = look_direction
	
	if !shadow:
		World.world.add_child(current_bullet)
		shadow = true
	current_bullet.tracer_func()
	
func on_on_ceasefire():
	current_bullet.fade()
	current_bullet = null
	shadow = false
	
func player_pos():
	Util.get_play_pos()
	pass
