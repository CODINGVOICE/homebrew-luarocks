require "formula"

class Luarocks53 < Formula

  homepage "http://luarocks.org"
  url "http://keplerproject.github.io/luarocks/releases/luarocks-2.3.0.tar.gz"
  sha256 "68e38feeb66052e29ad1935a71b875194ed8b9c67c2223af5f4d4e3e2464ed97"
  revision 1

  head "https://github.com/keplerproject/luarocks.git"

  depends_on "homebrew/versions/lua53"

  fails_with :llvm do
    cause "Lua itself compiles with llvm, but may fail when other software tries to link."
  end

  def install
    lua_prefix = Formula["lua53"].opt_prefix
    args = []
    args << "--prefix=#{prefix}"
    args << "--rocks-tree=#{HOMEBREW_PREFIX}"
    args << "--sysconfdir=#{etc}/luarocks"
    args << "--versioned-rocks-dir"
    args << "--with-lua=#{lua_prefix}"
    args << "--lua-version=5.3"
    args << "--lua-suffix=5.3"
    args << "--with-lua-include=#{lua_prefix}/include/lua-5.3"
    system "./configure", *args
    system "make", "build"
    system "make", "install"
    system "rm", "#{prefix}/bin/luarocks" # remove symlink
    system "rm", "#{prefix}/bin/luarocks-admin" # remove symlink
  end

  def caveats
    print "Luarocks is available at: #{HOMEBREW_PREFIX}/bin/luarocks-5.3\n"
    print "Rocks install to: #{HOMEBREW_PREFIX}/lib/luarocks/rocks-5.3\n"
    print "A configuration file has been placed at: #{HOMEBREW_PREFIX}/etc/luarocks/config-5.3.lua\n"
  end

  test do
    system "#{bin}/luarocks-5.3", "install", "say"
  end

end
