# slow5_aux_get_\<primitive_datatype\>

## NAME

slow5_aux_get_\<primitive_datatype\> - fetches an auxiliary field (a primitive datatype) from a SLOW5 record

## SYNOPSYS

```
int8_t slow5_aux_get_int8(const slow5_rec_t *read, const char *field, int *err)
int16_t slow5_aux_get_int16(const slow5_rec_t *read, const char *field, int *err)
int32_t slow5_aux_get_int32(const slow5_rec_t *read, const char *field, int *err)
int64_t slow5_aux_get_int64(const slow5_rec_t *read, const char *field, int *err)

uint8_t slow5_aux_get_uint8(const slow5_rec_t *read, const char *field, int *err)
uint16_t slow5_aux_get_uint16(const slow5_rec_t *read, const char *field, int *err)
uint32_t slow5_aux_get_uint32(const slow5_rec_t *read, const char *field, int *err)
uint64_t slow5_aux_get_uint64(const slow5_rec_t *read, const char *field, int *err)

float slow5_aux_get_float(const slow5_rec_t *read, const char *field, int *err)
double slow5_aux_get_double(const slow5_rec_t *read, const char *field, int *err)

char slow5_aux_get_char(const slow5_rec_t *read, const char *field, int *err)
```


## DESCRIPTION

`slow5_aux_get_<primitive_datatype>()` fetches the value of an auxiliary field of a primitive datatype specified by the field name *field* from the slow5 record pointed by *read*. User has to choose the appropriate function so that the returned datatype matches the correct datatype of the stored field, because the data stored in memory as a series of bytes will be reinterpreted as the requested type.

The argument *err* is an address of an integer which will be set inside the function call to indicate an error. Unless *err* is NULL, `slow5_aux_get_<primitive_datatype>()` sets a non zero error code in **err* in case of failure.

## RETURN VALUE

Upon successful completion, `slow5_aux_get_<primitive_datatype>()` returns the requested field value. Otherwise, the SLOW5 missing value representation for the particular datatype is returned (`SLOW5_INT8_T_NULL`, `SLOW5_INT16_T_NULL`, `SLOW5_INT32_T_NULL`, `SLOW5_INT64_T_NULL`, `SLOW5_UINT8_T_NULL`, `SLOW5_UINT16_T_NULL`, `SLOW5_UINT32_T_NULL`, `SLOW5_UINT64_T_NULL`, `SLOW5_FLOAT_NULL`, `SLOW5_DOUBLE_NULL` or `SLOW5_CHAR_NULL`) and `slow5_errno` is set to indicate the error.


## ERRORS

In case of an error, `slow5_errno` or the non zero error code is set in *err* (unless *err* is NULL) are as follows.


`SLOW5_ERR_NOFLD`
    &nbsp;&nbsp;&nbsp;&nbsp; The requested field was not found.
`SLOW5_ERR_NOAUX`
    &nbsp;&nbsp;&nbsp;&nbsp; Auxiliary hash map for the record was not found.
`SLOW5_ERR_ARG`   
    &nbsp;&nbsp;&nbsp;&nbsp; Invalid argument - read or field is NULL.
`SLOW5_ERR_TYPE`  
    &nbsp;&nbsp;&nbsp;&nbsp; Type conversion was not possible - an array data type field cannot be converted to a primitive type.


## NOTES

More error codes may be introduced in future.

## EXAMPLES
```
#include <stdio.h>
#include <stdlib.h>
#include <slow5/slow5.h>

#define FILE_PATH "examples/example2.slow5"

int main(){

    slow5_file_t *sp = slow5_open(FILE_PATH,"r");
    if(sp==NULL){
        fprintf(stderr,"Error in opening file\n");
        exit(EXIT_FAILURE);
    }
    slow5_rec_t *rec = NULL;
    int ret=0;
    ret = slow5_get_next(&rec,sp);
    if(ret<0){
        fprintf(stderr,"Error in slow5_get_next. Error code %d\n",ret);
        exit(EXIT_FAILURE);
    }

    //------------------------------------------------------------------------
    //              get auxiliary values with primitive datatype
    //------------------------------------------------------------------------
    ret=0;
    double median_before = slow5_aux_get_double(rec,"median_before",&ret);
    if(ret!=0){
        fprintf(stderr,"Error in getting auxiliary attribute from the file. Error code %d\n",ret);
        exit(EXIT_FAILURE);
    }
    fprintf(stderr,"median_before = %f\n", median_before);

    uint64_t start_time = slow5_aux_get_uint64(rec, "start_time", &ret);
    if(ret!=0){
        fprintf(stderr,"Error in getting auxiliary attribute from the file. Error code %d\n",ret);
        exit(EXIT_FAILURE);
    }
    fprintf(stderr,"start_time = %u\n", start_time);

    slow5_rec_free(rec);
    slow5_close(sp);

}
```

## SEE ALSO
[`slow5_aux_get_<array_datatype>()`](slow5_aux_get_array.md).
