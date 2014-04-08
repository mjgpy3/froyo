# encoding: UTF-8

module FroYo
  def make_fluent(*methods)
    methods.each do |method_name|
      define_method('_' + method_name.to_s) do |*args|
        send(method_name, *args)
        self
      end
    end
  end
end
