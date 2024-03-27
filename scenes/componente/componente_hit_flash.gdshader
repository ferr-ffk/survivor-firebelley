shader_type canvas_item;

// variavel global para acesso em script
uniform float porcentagem_lerp : hint_range(0.0, 1.0);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	
	vec4 cor_textura = texture(TEXTURE, UV);
	
	// mistura a cor e o uv padrão com um vetor branco, só que com o mesmo alfa (para que os pixels transparentes 
	// não possuam cor
 	// mix(textura_atual, vec4 representando o branco COM o alfa do pixel, alfa adicional)
	vec4 cor_final = mix(cor_textura, vec4(1.0, 1.0, 1.0, cor_textura.a), porcentagem_lerp);
	
	COLOR = cor_final;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
