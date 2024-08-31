def caeser_cipher(string, shift) 
  actualShift = shift % 26 # find out the actual shift in value, ignoring any loops (increments / decrements greater than 26)
  codepointsArray = string.codepoints # convert each character to a codepoint for modification
  shiftedArray = codepointsArray.map do |codepoint|
    if codepoint < 65 || codepoint > 122 then return codepoint end# although there is no fundamental issue in doing so, do not modify the character if not in the latin alphabet

    modified = codepoint + actualShift

    case 
      when modified < 65 then modified += 25 # if the modified codepoint ends up being less than the codepoint for "A", loop forward
      when modified > 90 && codepoint < 97 then modified -= 25 # if the modified codepoint ends up being more than the codepoint for "Z", and the original character wasn't lowercase ("a" or above), loop back
      when modified < 97 && codepoint >= 97 then modified += 25 # if the modified codepoints ends up being less than "a", but is lowercase, loop forward
      when modified > 122 then modified -= 25 # if modified more than "z", loop back
    end
    modified
  end

  shiftedArray.pack("U")
end

