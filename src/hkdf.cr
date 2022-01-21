# TODO: Write documentation for `Hkdf`
require "openssl/hmac"

module Hkdf
  VERSION = "0.1.0"

  def self.hmac(algo, key, data)
    OpenSSL::HMAC.digest(algo, key, data)
  end
  
  def self.hkdf(ikm, length=32 ,salt : Bytes=Bytes.empty, info : Bytes=Bytes.empty, algo=OpenSSL::Algorithm::SHA256)
    #prk = psuedorandom key
    prk = hmac(algo,salt, ikm)
    hash_len = prk.size 
    #Check for proper hash lenght
    if length > 255 * hash_len
      raise "Length cannot be larger than 255 * Hash Length"
    end

    n = (length/hash_len).ceil.to_i
    t = Array(Bytes).new
    t.push(Bytes.empty)
    (1..n).each do |i|
      buf = IO::Memory.new
      buf.write(t[i-1])
      buf.write(info)
      buf.write(i.chr)
      okm.push(hmac(algo, prk, buf))
    end

    okm = IO::Memory.new
    t.each do |b|
      okm.write_bytes(b)
    end

    return okm.to_slice

  end


end
