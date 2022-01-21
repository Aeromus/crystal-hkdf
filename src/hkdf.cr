# TODO: Write documentation for `Hkdf`
require "openssl/hmac"

module Hkdf
  VERSION = "0.1.0"

  def self.hmac(algo, key, data)
    OpenSSL::HMAC.digest(algo, key, data)
  end
  
  #IKM = Input Keying Materal, Salt = Optional salt value, Info = Optional contex and application specific information, Length = Length of the output keying material in octets
  def self.hkdf(ikm, length=32 ,salt : Bytes=Bytes.empty, info : Bytes=Bytes.empty, algo=OpenSSL::Algorithm::SHA256)
    #prk = pseudorandom key
    #Extract step
    prk = hmac(algo,salt, ikm)

    hash_len = prk.size 
    #Check for proper hash lenght
    raise "Length cannot be larger than 255 * Hash Length" if length > 255 * hash_len

    n = (length/hash_len).ceil.to_i
    t = Array(Bytes).new
    t.push(Bytes.empty)

    #Expand
    (1..n).each do |i|
      buf = IO::Memory.new
      buf.write(t[i-1])
      buf.write(info)
      buf.write_byte(i.to_u8)
      t.push(hmac(algo, prk, buf))
    end
    
    #OKM = Output Key Material (of Length octets)
    okm = IO::Memory.new
    t.each do |b|
      okm.write(b)
    end

    output = Bytes.new(length)
    okm.rewind
    okm.read(output)
    return output
    #okm.to_slice[0,length]
  end
end
