
meta:
  id: pj8
  file-extension: pj8
  endian: le
  #imports: ['/image/jpeg']
seq:
  - id: magic
    contents: 'EQ8PJ8'
  - id: file_header
    type: pj8_header
  - id: entry0
    size: 12
  - id: entry1
    type: u1
    repeat: expr
    repeat-expr: file_header.entry1.count
  - id: entry2
    type: u1
    repeat: expr
    repeat-expr: file_header.entry2.count
  - id: unknown1
    contents: [0x00]
  - id: unknown2
    type: u4
    repeat: expr
    repeat-expr: entry2[1]
  - id: unknown3
    type: unknown3_type
  - id: jpegs
    type: jpeg_entry
    repeat: expr
    repeat-expr: file_header.jpeg_entries.count
  - id: bloks
    type: blok_entry
    repeat: expr
    repeat-expr: file_header.blok_entries.count
types:
  blok:
    seq:
      - id: magic_header
        contents: 'BLOK'
  pj8_header:
    seq:
      - id: entry0
        type: allocation_table_entry
      - id: entry1
        type: allocation_table_entry
      - id: entry2
        type: allocation_table_entry
      - id: entry3
        type: allocation_table_entry
      - id: jpeg_entries
        type: allocation_table_entry
      - id: blok_entries
        type: allocation_table_entry
      - id: allocation_table
        repeat: expr
        repeat-expr: 14
        type:
          switch-on: _index
          cases:
            _: allocation_table_entry
      - id: allocation_table_ending
        contents: [0x0, 0x0]
      
      #- id: magic_ending
      #  contents: "EQ8!!:-)"
  allocation_table_entry:
    seq:
      - id: col1
        type: u2
      - id: start
        type: u4
      - id: count
        type: u2
  blok_entry:
    seq:
      - id: entry_length
        type: u4
      - id: stuff
        size: 52
      - id: blok_magic
        contents: "BLOK"
      - id: blok
        size: entry_length - 60
  jpeg_entry:
    seq:
      - id: entry_length
        type: u4
      - id: stuff
        size: 60
      - id: image
        size: entry_length - 64
        #type: jpeg
  generic_entry:
    seq:
      - id: entry_length
        type: u4
      - id: stuff
        size: entry_length - 64
  unknown3_type:
    seq:
      - id: count
        type: u2
      - id: items
        type: u2
        repeat: expr
        repeat-expr: count
