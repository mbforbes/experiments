class Lines

  def self.draw
    $app.line 0, 0, 100, 100
  end
end

Shoes.app do
  $app = self

  background red
  animate 60 do
    Lines.draw
  end
end
