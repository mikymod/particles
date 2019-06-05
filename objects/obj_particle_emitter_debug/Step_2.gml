if(!instance_exists(imgui))
	exit;

if (!imguigml_ready())
	exit;	

imguigml_set_next_window_size(400, 600, EImGui_Cond.FirstUseEver);
var _window = imguigml_begin("Particle Emitter", true);
if(_window[0])
{
	var _input;

#region number
	_input = imguigml_drag_int("Number", number, 1, 0, 50);
	if (_input[0])
	{
		number = _input[1];
	}
	
	imguigml_separator();
#endregion

#region region
	_input = imguigml_input_float4("Region", region_x, region_y, region_width, region_height, 0);
	if (_input[0])
	{
		region_x = _input[1];
		region_y = _input[2];
		region_width = _input[3];
		region_height = _input[4];
	}
	imguigml_separator();
#endregion

#region shape
	var rshapes = [
		ps_shape_rectangle,
		ps_shape_ellipse,
		ps_shape_diamond,
		ps_shape_line
	];

	_input = imguigml_combo("RShape", shape, rshapes);
	if (_input[0])
	{
		shape = _input[1];
	}
	
	imguigml_separator();
#endregion

#region distribution
	var distributions = [
		ps_distr_linear,
		ps_distr_gaussian,
		ps_distr_invgaussian
	];
	
	_input = imguigml_combo("Distribution", distribution, distributions);
	if (_input[0])
		distribution = _input[1];
		
	imguigml_separator();
#endregion

#region stream
	_input = imguigml_checkbox("Stream", stream);
	if (_input[0])
	{
		stream = _input[1];
		part_emitter_stream(_system, _emitter, _type, 0);
	}
	
	imguigml_separator();
#endregion

#region type_shape
	var shapes = [
		pt_shape_pixel,
		pt_shape_disk,
		pt_shape_square,
		pt_shape_line,
		pt_shape_star,
		pt_shape_circle,
		pt_shape_ring,
		pt_shape_sphere,
		pt_shape_flare,
		pt_shape_spark,
		pt_shape_explosion,
		pt_shape_cloud,
		pt_shape_smoke,
		pt_shape_snow
	];
	_input = imguigml_combo("Shape", type_shape, shapes);
	if (_input[0])
	{
		type_shape = _input[1];
	}
	
	imguigml_separator();
#endregion

#region type_size
	_input = imguigml_drag_float4("Size", type_size_min, type_size_max, type_size_incr, type_size_wiggle, 0.1, 0.1, 2.0, "%.2f");
	if (_input[0])
	{
		type_size_min    = _input[1];
		type_size_max    = _input[2];
		type_size_incr   = _input[3];
		type_size_wiggle = _input[4];
	}
	
	imguigml_separator();
#endregion

#region type_scale
	_input = imguigml_drag_float2("scale", type_scale_x, type_scale_y, 0.1, -2.0, -2.0, "%.2f");
	if (_input[0])
	{
		type_scale_x = _input[1];
		type_scale_y = _input[2];
	}
	
	imguigml_separator();
#endregion

#region type_color

	var _colour = imguigml_color_convert_u32_to_float4(imguigml_color_convert_gml_to_u32(type_color_1, type_alpha_1));
	var _input = imguigml_color_edit4("Color 1", _colour[0], _colour[1], _colour[2],_colour[3]);
	if (_input[0])
	{
		_input = [_input[1], _input[2], _input[3], _input[4]];
		_colour = imguigml_color_convert_u32_to_gml(imguigml_color_convert_float4_to_u32(_input));
		type_color_1 = _colour[0];
		type_alpha_1 = _colour[1];
	}
	
	var _colour = imguigml_color_convert_u32_to_float4(imguigml_color_convert_gml_to_u32(type_color_2, type_alpha_2));
	var _input = imguigml_color_edit4("Color 2", _colour[0], _colour[1], _colour[2],_colour[3]);
	if (_input[0])
	{
		_input = [_input[1], _input[2], _input[3], _input[4]];
		_colour = imguigml_color_convert_u32_to_gml(imguigml_color_convert_float4_to_u32(_input));
		type_color_2 = _colour[0];
		type_alpha_2 = _colour[1];
	}

	var _colour = imguigml_color_convert_u32_to_float4(imguigml_color_convert_gml_to_u32(type_color_3, type_alpha_3));
	var _input = imguigml_color_edit4("Color 3", _colour[0], _colour[1], _colour[2],_colour[3]);
	if (_input[0])
	{
		_input = [_input[1], _input[2], _input[3], _input[4]];
		_colour = imguigml_color_convert_u32_to_gml(imguigml_color_convert_float4_to_u32(_input));
		type_color_3 = _colour[0];
		type_alpha_3 = _colour[1];
	}
	
	imguigml_separator();
#endregion

#region type_speed
	_input = imguigml_drag_float4("Speed", type_speed_min, type_speed_max, type_speed_incr, type_speed_wiggle, 0.1, -5.0, 5.0, "%.2f");
	if (_input[0])
	{
		type_speed_min    = _input[1];
		type_speed_max    = _input[2];
		type_speed_incr   = _input[3];
		type_speed_wiggle = _input[4];
	}
	
	imguigml_separator();
#endregion

#region type_direction 
	_input = imguigml_drag_int4("Direction", type_dir_min, type_dir_max, type_dir_incr, type_dir_wiggle, 1, 0, 359);
	if (_input[0])
	{
		type_dir_min    = _input[1];
		type_dir_max    = _input[2];
		type_dir_incr   = _input[3];
		type_dir_wiggle = _input[4];
	}
	
	imguigml_separator();
#endregion

#region type_gravity
	_input = imguigml_drag_float("Gravity", type_gravity, 0.1, 0.1, "%.3f");
	if (_input[0])
		type_gravity = _input[1];
	
	_input = imguigml_drag_int("Gravity Direction", type_gravity_dir, 1, 0, 359);
	if (_input[0])
		type_gravity_dir = _input[1];

	_input = imguigml_checkbox("Gravity Enabled", type_gravity_enabled);
	if (_input[0])
		type_gravity_enabled = _input[1];
		
	imguigml_separator();
#endregion

#region type_orientation
	_input = imguigml_drag_int4("Orientation", type_orientation_min, type_orientation_max, type_orientation_incr, type_orientation_wiggle, 1, 0, 359);
	if (_input[0])
	{
		type_orientation_min    = _input[1];
		type_orientation_max    = _input[2];
		type_orientation_incr   = _input[3];
		type_orientation_wiggle = _input[4];
	}
	
	_input = imguigml_checkbox("Relative", type_orientation_relative);
	if (_input[0])
	{
		type_orientation_relative = _input[1];
	}
	
	imguigml_separator();
#endregion

#region type_blend
	_input = imguigml_checkbox("Blend", type_blend);
	if (_input[0])
	{
		type_blend = _input[1];
	}
	
	imguigml_separator();
#endregion

#region type_lifetime
_input = imguigml_drag_int2("Lifetime", type_life_min, type_life_max, 1, 1, 60 * 5);
if (_input[0])
{
	type_life_min = _input[1];
	type_life_max = _input[2];
}
#endregion

}

imguigml_end();