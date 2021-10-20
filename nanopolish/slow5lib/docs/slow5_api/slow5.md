# slow5lib

## NAME

slow5lib - slow5 Overview

## DESCRIPTION

slow5lib is a library for reading and writing SLOW5 files. Compiling slow5lib requires a C compiler that conforms to at least c99 standard with X/Open 7, incorporating POSIX 2008 extension support.


### High-level API for reading SLOW5 files

High-level API for reading SLOW5 files consists of following functions:

* [slow5_open](slow5_open.md)  
  &nbsp;&nbsp;&nbsp;&nbsp;opens a SLOW5 file
* [slow5_close](slow5_close.md)  
  &nbsp;&nbsp;&nbsp;&nbsp;closes a  SLOW5 file
* [slow5_get](slow5_get.md)  
  &nbsp;&nbsp;&nbsp;&nbsp;fetches a record corresponding to a given read ID
* [slow5_get_next](slow5_get_next.md)  
  &nbsp;&nbsp;&nbsp;&nbsp;fetches the record at the current file pointer of a slow5 file
* [slow5_idx_create](slow5_idx_create.md)  
  &nbsp;&nbsp;&nbsp;&nbsp;creates an index file for a SLOW5 file
* [slow5_idx_load](slow5_idx_load.md)  
  &nbsp;&nbsp;&nbsp;&nbsp;loads the index file for a SLOW5 file
* [slow5_idx_unload](slow5_idx_unload.md)  
  &nbsp;&nbsp;&nbsp;&nbsp;unloads a SLOW5 index from the memory
* [slow5_rec_free](slow5_rec_free.md)  
  &nbsp;&nbsp;&nbsp;&nbsp;frees up a SLOW5 record from memory
* [slow5_hdr_get](slow5_hdr_get.md)  
  &nbsp;&nbsp;&nbsp;&nbsp;fetches a header data attribute from a SLOW5 header
*  [slow5_aux_get\_*\<primitive_datatype\>*](slow5_aux_get.md)  
  &nbsp;&nbsp;&nbsp;&nbsp;fetches an auxiliary field (a primitive datatype) from a SLOW5 record 
  &nbsp;&nbsp;&nbsp;&nbsp;Following functions are available:
    - [slow5_aux_get_int8](slow5_aux_get.md)
    - [slow5_aux_get_int16](slow5_aux_get.md)
    - [slow5_aux_get_int32](slow5_aux_get.md)
    - [slow5_aux_get_int64](slow5_aux_get.md)
    - [slow5_aux_get_uint8](slow5_aux_get.md)
    - [slow5_aux_get_uint16](slow5_aux_get.md)
    - [slow5_aux_get_uint32](slow5_aux_get.md)
    - [slow5_aux_get_uint64](slow5_aux_get.md)
    - [slow5_aux_get_float](slow5_aux_get.md)
    - [slow5_aux_get_double](slow5_aux_get.md)
    - [slow5_aux_get_char](slow5_aux_get.md)

*   [slow5_aux_get\_*\<array_datatype\>*](slow5_aux_get_array.md)  
    &nbsp;&nbsp;&nbsp;&nbsp;fetches an auxiliary field (an array datatype) of a SLOW5 record 
    &nbsp;&nbsp;&nbsp;&nbsp;Following functions are available:  
    * [slow5_aux_get_int8_array](slow5_aux_get_array.md)
    * [slow5_aux_get_int16_array](slow5_aux_get_array.md)
    * [slow5_aux_get_int32_array](slow5_aux_get_array.md)
    * [slow5_aux_get_int64_array](slow5_aux_get_array.md)
    * [slow5_aux_get_uint8_array](slow5_aux_get_array.md)
    * [slow5_aux_get_uint16_array](slow5_aux_get_array.md)
    * [slow5_aux_get_uint32_array](slow5_aux_get_array.md)
    * [slow5_aux_get_uint64_array](slow5_aux_get_array.md)
    * [slow5_aux_get_float_array](slow5_aux_get_array.md)
    * [slow5_aux_get_double_array](slow5_aux_get_array.md)
    * [slow5_aux_get_string](slow5_aux_get_array.md)

<!--
### Low-level API for reading and writing SLOW5 files
* [slow5_open_with](low_level_api/slow5_open_with.md)
    Open a SLOW5 file. User can specify the SLOW5 format.
-->

The *slow5_file_t* structure stores the file pointer, parsed SLOW5 header and other metadata of an opened SLOW5 file.
The user can directly access the struct member *slow5_hdr_t *header* which contains the pointer to the parsed SLOW5 header.
Other struct members are private and not supposed to be directly accessed.

The *slow5_hdr_t* structure stores a parsed SLOW5 header. This structure has the following form:

```
typedef struct {

    /* private struct members that are not supposed to be directly accessed are not shown.
       the order of the memebers in this struct can subject to change.
    */

    struct slow5_version version;       // SLOW5 file version
    uint32_t num_read_groups;           // Number of read groups

} slow5_hdr_t;
```

The slow5_version structure contains the major, minor and patch version as follows:

```
struct slow5_version {
    uint8_t major;  // major version
    uint8_t minor;  // minor version
    uint8_t patch;  // patch version
};
```

The *slow5_rec_t* structure stores a parsed slow5 record. This structure has the following form:

```
typedef struct {
    slow5_rid_len_t read_id_len;        // length of the read ID string (does not include null character)
    char* read_id;                      // the read ID
    uint32_t read_group;                // the read group
    double digitisation;                // the number of quantisation levels - required to convert the signal to pico ampere
    double offset;                      // offset value - required to convert the signal to pico ampere
    double range;                       // range value - required to convert to pico ampere
    double sampling_rate;               // the sampling rate at which the signal was acquired
    uint64_t len_raw_signal;            // length of the raw signal array
    int16_t* raw_signal;                // the actual raw signal array

    /* Other private members for storing auxilliary field which are not to be directly accessed*/

} slow5_rec_t;
```

### Low-level API for reading and writing SLOW5 files

prototypes are not yet finalised and subject to change.
