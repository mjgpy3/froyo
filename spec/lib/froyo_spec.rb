# encoding: UTF-8

require './lib/froyo'

describe FroYo do

  context "when a class does not extend #{described_class.inspect}" do

    class DontExtend
    end

    it 'raises a NoMethodError when a method beginning with an underscore (that is not defined) is called' do
      expect { DontExtend.new._foo }.to raise_error(NoMethodError)
    end

  end

  context "when a class extends #{described_class.inspect}" do

    class ExtendsFroYo
      extend FroYo
    end

    context 'and it has a method that it has not defined as being fluent' do

      class ExtendsFroYo
        def not_fluent
        end
      end

      it 'does not respond to that method, beginning with an underscore' do
        ExtendsFroYo.new.should_not respond_to(:_not_fluent)
      end

      it 'does not return that instance' do
        instance = ExtendsFroYo.new
        instance.not_fluent.should_not be_equal(instance)
      end

    end

    context 'and it has a no-parameter method that it has been defined as being fluent' do

      class ExtendsFroYo
        def no_param_fluent
        end

        make_fluent :no_param_fluent
      end

      it 'responds to that method with an underscore' do
        ExtendsFroYo.new.should respond_to(:_no_param_fluent)
      end

      it 'calls the original method, when the underscored version is called' do
        instance = ExtendsFroYo.new
        instance.should_receive(:no_param_fluent)
        instance._no_param_fluent
      end

      it 'returns that instance' do
        instance = ExtendsFroYo.new
        instance._no_param_fluent.should be_equal(instance)
      end

      it 'returns that instance even when multiple calls are chained' do
        instance = ExtendsFroYo.new
        instance._no_param_fluent._no_param_fluent._no_param_fluent.should be_equal(instance)
      end

    end

    context 'and it has a multi-parameter method that has been defined as being fluent' do

      class ExtendsFroYo
        def multi_param_fluent(foo, bar)
        end

        make_fluent :multi_param_fluent
      end

      it 'calls the original with the passed params' do
        instance = ExtendsFroYo.new
        instance.should_receive(:multi_param_fluent).with('foo val', 'bar val')
        instance._multi_param_fluent('foo val', 'bar val')
      end

    end

    context 'and it has an infinite arity method that is defined as being fluent' do

      class ExtendsFroYo
        def inf_arity_fluent(*args)
        end

        make_fluent :inf_arity_fluent
      end

      it 'calls the original with the passed params' do
        instance = ExtendsFroYo.new
        instance.should_receive(:inf_arity_fluent).with(1, 2, 3, 4)
        instance._inf_arity_fluent(1, 2, 3, 4)
      end

    end

    context 'and it has a method accepting a block that is defined as being fluent' do

      class ExtendsFroYo
        def accepts_block_fluent(&block)
        end

        make_fluent :accepts_block_fluent
      end

      it 'calls the original with the passed params' do
        instance = ExtendsFroYo.new
        some_block = lambda do |x, y, z|
          puts 'never called'
        end
        instance.should_receive(:accepts_block_fluent).with(some_block)
        instance._accepts_block_fluent(some_block)
      end

    end

    context 'and it has a method accepting a param, inf arity params, and a block that is defined as being fluent' do

      class ExtendsFroYo
        def accepts_lots_fluent(param, *args, &block)
        end

        make_fluent :accepts_lots_fluent
      end

      it 'receives the original with all the passed params' do
        instance = ExtendsFroYo.new
        some_block = ->(x, y, z) {}
        instance.should_receive(:accepts_lots_fluent).with(1, 2, 3, some_block)
        instance._accepts_lots_fluent(1, 2, 3, some_block)
      end

    end

    context 'and it has multiple methods that are defined as being fluent' do

      class ExtendsFroYo
        def foo
        end

        def bar
        end

        make_fluent :foo, :bar
      end

      it 'responds to all methods that were defined as being fluent' do
        ExtendsFroYo.new.should respond_to(:_foo)
        ExtendsFroYo.new.should respond_to(:_bar)
      end

      it 'returns the instance when multiple, alternating chainings are done' do
        instance = ExtendsFroYo.new
        instance._foo
                ._bar
                ._foo
                ._bar.should equal(instance)
          
      end

    end

  end

end
