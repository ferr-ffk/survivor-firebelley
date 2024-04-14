shader_type canvas_item;

uniform vec4 cor_transicao : source_color;
// filtraos pixels para os mais proximos
uniform sampler2D textura_transicao : filter_nearest;
uniform float porcentagem : hint_range(0.0, 1.0);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 cor_textura_transicao = texture(textura_transicao, UV);
	
	// com base na textura, filtra os pixels mais proximos do centro para ficarem transparentes
	// por conta da porcentagem de vermelho ser menor que a porcentagem
	if (cor_textura_transicao.r > porcentagem) {
		COLOR.a = 0.0;
	} else {
		COLOR = cor_transicao;
	}
	
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
 