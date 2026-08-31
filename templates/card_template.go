components {
  id: "card"
  component: "/templates/card.script"
}
embedded_components {
  id: "card_bg"
  type: "sprite"
  data: "default_animation: \"common\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/background.atlas\"\n"
  "}\n"
  ""
}
embedded_components {
  id: "card_text"
  type: "label"
  data: "size {\n"
  "  x: 128.0\n"
  "  y: 32.0\n"
  "}\n"
  "color {\n"
  "  x: 0.0\n"
  "  y: 0.0\n"
  "  z: 0.0\n"
  "}\n"
  "text: \"Label\"\n"
  "font: \"/builtins/fonts/default.font\"\n"
  "material: \"/builtins/fonts/label-df.material\"\n"
  ""
  position {
    x: -2.0
    y: 400.0
  }
  scale {
    x: 5.0
    y: 5.0
  }
}
embedded_components {
  id: "card_image"
  type: "sprite"
  data: "default_animation: \"Zero Two\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/character.atlas\"\n"
  "}\n"
  ""
  position {
    z: 0.5
  }
}
