
def degrees_to_semicircle(degrees)
  (degrees.to_f * ((2**31).to_f / 180.to_f)).to_i
end

def semicircle_to_degrees(semi)
  (semi.to_f * ( 180.to_f / 2.to_f**31 ).to_f).to_f
end

def is_degree?(value)
  # value.to_s =~ /\./
  value.to_s =~ /^(\-|\+)?\d{1,4}\.\d+$/
end