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
  "  texture: \"/assets/Cards_bg/background.atlas\"\n"
  "}\n"
  ""
  scale {
    x: 0.4
    y: 0.4
  }
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
    y: 159.0
    z: 0.03
  }
}
embedded_components {
  id: "card_image"
  type: "sprite"
  data: "default_animation: \"1_com\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "size {\n"
  "  x: 445.0\n"
  "  y: 750.0\n"
  "}\n"
  "size_mode: SIZE_MODE_MANUAL\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/Character_images/character.atlas\"\n"
  "}\n"
  ""
  position {
    y: -16.0
    z: 0.02
  }
  scale {
    x: 0.4
    y: 0.4
  }
}
embedded_components {
  id: "reward_text"
  type: "label"
  data: "size {\n"
  "  x: 128.0\n"
  "  y: 32.0\n"
  "}\n"
  "text: \"Label\"\n"
  "font: \"/builtins/fonts/default.font\"\n"
  "material: \"/builtins/fonts/label-df.material\"\n"
  ""
  position {
    y: 210.0
    z: 0.04
  }
}
