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
  - id: preview_header
    type: preview_header
instances:
  jpegs:
    pos: _root.file_header.jpeg_entries.start
    type: jpeg_entry
    repeat: expr
    repeat-expr: _root.file_header.jpeg_entries.count
  bloks:
    pos: _root.file_header.blok_entries.start
    type: blok_entry
    repeat: expr
    repeat-expr: _root.file_header.blok_entries.count
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
        type: allocation_table_entry
        repeat: expr
        repeat-expr: 14
      - id: allocation_table_ending
        contents: [0x0, 0x0, 0x49, 0x03]
      - id: magic_ending
        contents: "EQ8!!:-)"
  allocation_table_entry:
    seq:
      - id: col1
        type: u2
      - id: start
        type: u4
      - id: count
        type: u2
  preview_header:
    seq:
      - id: len1
        type: u1
      - id: len2
        type: u1
      - id: header1
        size: len1
      - id: header2
        size: len2
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
