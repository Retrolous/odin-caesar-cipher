require "pry-byebug"

def caeser_cipher(string, shift = 0) 
  actualShift = shift.to_i % 26 # find out the actual shift in value, ignoring any loops (increments / decrements greater than 26)
  codepointsArray = string.to_s.codepoints # convert each character to a codepoint for modification
  shiftedArray = codepointsArray.map do |codepoint|
    if codepoint < 65 || codepoint > 122 then next codepoint.chr(Encoding::UTF_8) end # although there is no fundamental issue in doing so, do not modify the character if not in the latin alphabet

    modified = codepoint + actualShift

    case 
      when modified < 65 then modified += 25 # if the modified codepoint ends up being less than the codepoint for "A", loop forward
      when modified > 90 && codepoint < 97 then modified -= 25 # if the modified codepoint ends up being more than the codepoint for "Z", and the original character wasn't lowercase ("a" or above), loop back
      when modified < 97 && codepoint >= 97 then modified += 25 # if the modified codepoints ends up being less than "a", but is lowercase, loop forward
      when modified > 122 then modified -= 25 # if modified more than "z", loop back
    end
    
    modified.chr(Encoding::UTF_8)
  end
  shiftedArray.join("")
end

# puts caeser_cipher("aTtAckatdaWN", 2) # works normally
# puts caeser_cipher("aTtAckatdaWN", 22131382131) # works with large shift
# puts caeser_cipher("aTtAcka%%%t, daWN", 2) # works with special characters
# puts caeser_cipher("aTtAckatdaWN", -2) # works with negative shift
# puts caeser_cipher("aTtAckatdaWN", -28) # works with large negative shift
# puts caeser_cipher("", -28) # works with no string
# puts caeser_cipher("gruh", 0) # works with no shift
# puts caeser_cipher("", -28) # works with no string
# puts caeser_cipher("gruh", 23.4) # works with float shift
# puts caeser_cipher(:gruh, 23) # works with non-string input