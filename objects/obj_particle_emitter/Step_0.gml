// System
part_system_depth(_system, 0);
//part_system_position(_system, pos_x, pos_y);

// Type
if (sprite == noone)
	part_type_shape(_type, type_shape);
else
	part_type_sprite(_type, sprite, 0, 0, 1);

part_type_size(_type, type_size_min, type_size_max, type_size_incr, type_size_wiggle);
part_type_scale(_type, type_scale_x, type_scale_y);
part_type_color3(_type, type_color_1, type_color_2, type_color_3);
part_type_alpha3(_type, type_alpha_1, type_alpha_2, type_alpha_3);
part_type_speed(_type, type_speed_min, type_speed_max, type_speed_incr, type_speed_wiggle);
part_type_direction(_type, type_dir_min, type_dir_max, type_dir_incr, type_dir_wiggle);
if (type_gravity_enabled)
	part_type_gravity(_type, type_gravity, type_gravity_dir);
part_type_orientation(_type, type_orientation_min, type_orientation_max, type_orientation_incr, type_orientation_wiggle, type_orientation_relative);
part_type_blend(_type, type_blend);
part_type_life(_type, type_life_min, type_life_max);

// 
part_emitter_region(_system, _emitter, region_x, region_width, region_y, region_height, shape, distribution);
if (stream)
{
	part_emitter_stream(_system, _emitter, _type, number);
}
else
{
	if (keyboard_check_pressed(vk_space))
		part_emitter_burst(_system, _emitter, _type, number);
}
