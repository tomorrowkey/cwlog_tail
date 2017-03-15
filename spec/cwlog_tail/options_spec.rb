require 'spec_helper'
require 'cwlog_tail/options'

describe CwlogTail::Options do
  let(:options) { CwlogTail::Options.new(argv) }

  describe '#follow?' do
    context 'when do not set any args' do
      let(:argv) { [] }

      it 'returns false' do
        expect(options.follow?).to be_falsey
      end
    end

    context 'when set -f option' do
      let(:argv) { ['-f'] }

      it 'returns true' do
        expect(options.follow?).to be_truthy
      end
    end

    context 'when set -f option' do
      let(:argv) { ['--follow'] }

      it 'returns true' do
        expect(options.follow?).to be_truthy
      end
    end
  end

  describe '#lines' do
    context 'when do not set any args' do
      let(:argv) { [] }

      it 'returns nil' do
        expect(options.lines).to be_nil
      end
    end

    context 'when set 20 lines with -n' do
      let(:argv) { ['-n', '20'] }

      it 'returns 20' do
        expect(options.lines).to eq(20)
      end
    end

    context 'when set 20 lines with --lines' do
      let(:argv) { ['--lines', '20'] }

      it 'returns 20' do
        expect(options.lines).to eq(20)
      end
    end

    context 'when missing numeric' do
      let(:argv) { ['-n'] }

      it 'returns nil' do
        expect(options.lines).to be_nil
      end
    end
  end
end
