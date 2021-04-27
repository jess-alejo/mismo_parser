# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

RSpec.describe MismoParser::Component::Address do
  let(:subject) { described_class.new raw_data }

  let(:parser) { XmlHasher::Parser.new(snakecase: false, ignore_namespaces: false, string_keys: true) }

  let(:xml) do
    <<-XML
      <PROPERTY>
        <ADDRESS>
          <AddressLineText>123 Main St,</AddressLineText>
          <AddressUnitIdentifier>Building E, Apartment 2</AddressUnitIdentifier>
          <CityName>New York</CityName>
          <PostalCode>11111</PostalCode>
          <StateCode>NY</StateCode>
        </ADDRESS>
      </PROPERTY>
    XML
  end

  let(:raw_data) { parser.parse(xml)['PROPERTY'] }

  it 'parses street' do
    expect(subject.street).to eq '123 Main St,'
  end

  it 'parses unit' do
    expect(subject.unit).to eq 'Building E, Apartment 2'
  end

  it 'parses city' do
    expect(subject.city).to eq 'New York'
  end

  it 'parses zip' do
    expect(subject.zip).to eq '11111'
  end

  it 'parses state' do
    expect(subject.state).to eq 'NY'
  end
end

# rubocop:enable Metrics/BlockLength
