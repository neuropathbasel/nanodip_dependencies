#include <float.h>
#include "unit_test.h"
#include <slow5/slow5.h>
#include "slow5_extra.h"

int slow5_open_valid(void) {
    struct slow5_file *s5p = slow5_open("test/data/exp/one_fast5/exp_1_lossless.slow5", "r");
    ASSERT(s5p != NULL);

    ASSERT(slow5_close(s5p) == 0);

    return EXIT_SUCCESS;
}

int slow5_get_valid(void) {
    struct slow5_file *s5p = slow5_open("test/data/exp/one_fast5/exp_1_lossless.slow5", "r");
    ASSERT(s5p != NULL);
    ASSERT(slow5_idx_load(s5p) == 0);

    struct slow5_rec *read = NULL;
    ASSERT(slow5_get("a649a4ae-c43d-492a-b6a1-a5b8b8076be4", &read, s5p) == 0);
    slow5_rec_free(read);

    ASSERT(slow5_close(s5p) == 0);

    return EXIT_SUCCESS;
}

int slow5_aux_get_valid(void) {
    struct slow5_file *s5p = slow5_open("test/data/exp/one_fast5/exp_1_lossless.slow5", "r");
    ASSERT(s5p != NULL);
    ASSERT(slow5_idx_load(s5p) == 0);

    struct slow5_rec *read = NULL;
    ASSERT(slow5_get("a649a4ae-c43d-492a-b6a1-a5b8b8076be4", &read, s5p) == 0);
    int err;
    char *cn = slow5_aux_get_string(read, "channel_number", NULL, &err);
    ASSERT(cn != NULL);
    ASSERT(strcmp(cn, "115") == 0);
    ASSERT(err == 0);
    double mb = slow5_aux_get_double(read, "median_before", &err);
    ASSERT(mb == 225.114);
    ASSERT(err == 0);
    ASSERT(slow5_aux_get_int32(read, "read_number", &err) == 222);
    ASSERT(err == 0);
    ASSERT(slow5_aux_get_uint8(read, "start_mux", &err) == 1);
    ASSERT(err == 0);
    ASSERT(slow5_aux_get_uint64(read, "start_time", &err) == 2817564);
    ASSERT(err == 0);

    ASSERT(slow5_close(s5p) == 0);

    s5p = slow5_open("test/data/exp/two_rg/exp_lossless.slow5", "r");
    ASSERT(s5p != NULL);
    ASSERT(slow5_idx_load(s5p) == 0);

    ASSERT(slow5_get("a649a4ae-c43d-492a-b6a1-a5b8b8076be4", &read, s5p) == 0);
    uint64_t len;
    cn = slow5_aux_get_string(read, "channel_number", &len, &err);
    ASSERT(cn != NULL);
    ASSERT(strcmp(cn, "115") == 0);
    ASSERT(len == 3);
    ASSERT(err == 0);
    cn = slow5_aux_get_string(read, "channel_number", NULL, NULL);
    ASSERT(cn != NULL);
    ASSERT(strcmp(cn, "115") == 0);
    mb = slow5_aux_get_double(read, "median_before", &err);
    ASSERT(mb == 225.114);
    ASSERT(err == 0);
    ASSERT(slow5_aux_get_int32(read, "read_number", &err) == 222);
    ASSERT(err == 0);
    ASSERT(slow5_aux_get_uint8(read, "start_mux", &err) == 1);
    ASSERT(err == 0);
    ASSERT(slow5_aux_get_uint64(read, "start_time", &err) == 2817564);
    ASSERT(err == 0);

    ASSERT(slow5_get("40aac17d-56a6-44db-934d-c0dbb853e2cd", &read, s5p) == 0);
    cn = slow5_aux_get_string(read, "channel_number", NULL, &err);
    ASSERT(cn != NULL);
    ASSERT(strcmp(cn, "123") == 0);
    ASSERT(err == 0);
    mb = slow5_aux_get_double(read, "median_before", &err);
    ASSERT(mb == 220.292);
    ASSERT(err == 0);
    ASSERT(slow5_aux_get_int32(read, "read_number", &err) == 2477);
    ASSERT(err == 0);
    ASSERT(slow5_aux_get_uint8(read, "start_mux", &err) == 3);
    ASSERT(err == 0);
    ASSERT(slow5_aux_get_uint64(read, "start_time", &err) == 38528872);
    ASSERT(err == 0);

    ASSERT(slow5_close(s5p) == 0);

    s5p = slow5_open("test/data/exp/one_fast5/exp_1_lossless.blow5", "r");
    ASSERT(s5p != NULL);
    ASSERT(slow5_idx_load(s5p) == 0);

    ASSERT(slow5_get("a649a4ae-c43d-492a-b6a1-a5b8b8076be4", &read, s5p) == 0);
    cn = slow5_aux_get_string(read, "channel_number", NULL, &err);
    ASSERT(cn != NULL);
    ASSERT(strcmp(cn, "115") == 0);
    ASSERT(err == 0);
    mb = slow5_aux_get_double(read, "median_before", &err);
    ASSERT(mb == 225.114);
    ASSERT(err == 0);
    ASSERT(slow5_aux_get_int32(read, "read_number", &err) == 222);
    ASSERT(err == 0);
    ASSERT(slow5_aux_get_uint8(read, "start_mux", &err) == 1);
    ASSERT(err == 0);
    ASSERT(slow5_aux_get_uint64(read, "start_time", &err) == 2817564);
    ASSERT(err == 0);

    ASSERT(slow5_close(s5p) == 0);

    s5p = slow5_open("test/data/exp/one_fast5/exp_1_lossless_gzip.blow5", "r");
    ASSERT(s5p != NULL);
    ASSERT(slow5_idx_load(s5p) == 0);

    ASSERT(slow5_get("a649a4ae-c43d-492a-b6a1-a5b8b8076be4", &read, s5p) == 0);
    cn = slow5_aux_get_string(read, "channel_number", NULL, &err);
    ASSERT(cn != NULL);
    ASSERT(strcmp(cn, "115") == 0);
    ASSERT(err == 0);
    mb = slow5_aux_get_double(read, "median_before", &err);
    ASSERT(mb == 225.114);
    ASSERT(err == 0);
    ASSERT(slow5_aux_get_int32(read, "read_number", &err) == 222);
    ASSERT(err == 0);
    ASSERT(slow5_aux_get_uint8(read, "start_mux", &err) == 1);
    ASSERT(err == 0);
    ASSERT(slow5_aux_get_uint64(read, "start_time", &err) == 2817564);
    ASSERT(err == 0);

    ASSERT(slow5_close(s5p) == 0);
    slow5_rec_free(read);

    return EXIT_SUCCESS;
}

int slow5_aux_get_invalid(void) {
    struct slow5_file *s5p = slow5_open("test/data/exp/one_fast5/exp_1_lossless.slow5", "r");
    ASSERT(s5p != NULL);
    ASSERT(slow5_idx_load(s5p) == 0);

    struct slow5_rec *read = NULL;
    ASSERT(slow5_get("a649a4ae-c43d-492a-b6a1-a5b8b8076be4", &read, s5p) == 0);

    int err;
    char *cn = slow5_aux_get_string(read, "channel_numbe", NULL, &err);
    ASSERT(cn == NULL);
    ASSERT(err == SLOW5_ERR_NOFLD);
    double mb = slow5_aux_get_double(read, "", &err);
    ASSERT(isnan(mb));
    ASSERT(err == SLOW5_ERR_NOFLD);
    ASSERT(slow5_aux_get_int32(read, "read_nu", &err) == INT32_MAX);
    ASSERT(err == SLOW5_ERR_NOFLD);
    ASSERT(slow5_aux_get_uint8(read, "mux", &err) == UINT8_MAX);
    ASSERT(err == SLOW5_ERR_NOFLD);
    ASSERT(slow5_aux_get_uint64(read, "start_time", &err) != 2817563);
    ASSERT(err == 0);

    ASSERT(slow5_aux_get_string(read, "start_time", NULL, &err) == NULL);
    ASSERT(slow5_aux_get_string(NULL, "start_time", NULL, &err) == NULL);
    ASSERT(slow5_aux_get_string(NULL, NULL, NULL, &err) == NULL);
    ASSERT(slow5_aux_get_string(read, NULL, NULL, &err) == NULL);
    ASSERT(slow5_aux_get_string(read, NULL, NULL, NULL) == NULL);

    ASSERT(slow5_aux_get_int8(read, "start_time", &err) == SLOW5_INT8_T_NULL);
    ASSERT(err == SLOW5_ERR_TYPE);
    ASSERT(slow5_aux_get_int8_array(read, "start_time", NULL, &err) == NULL);
    ASSERT(err == SLOW5_ERR_TYPE);
    ASSERT(isnan(slow5_aux_get_float(read, "start_time", &err)));
    ASSERT(err == SLOW5_ERR_TYPE);
    ASSERT(slow5_aux_get_float_array(read, "start_time", NULL, &err) == NULL);
    ASSERT(err == SLOW5_ERR_TYPE);

    slow5_rec_free(read);

    ASSERT(slow5_close(s5p) == 0);

    return EXIT_SUCCESS;
}

int blow5_get_valid(void) {
    struct slow5_file *s5p = slow5_open("test/data/exp/one_fast5/exp_1_lossless.blow5", "r");
    ASSERT(s5p != NULL);
    ASSERT(slow5_idx_load(s5p) == 0);

    struct slow5_rec *read = NULL;
    ASSERT(slow5_get("a649a4ae-c43d-492a-b6a1-a5b8b8076be4", &read, s5p) == 0);
    slow5_rec_free(read);

    ASSERT(slow5_close(s5p) == 0);

    return EXIT_SUCCESS;
}

int blow5_rec_get_valid(void) {
    struct slow5_file *s5p = slow5_open("test/data/exp/one_fast5/exp_1_lossless.blow5", "r");
    ASSERT(s5p != NULL);
    ASSERT(slow5_idx_load(s5p) == 0);

    struct slow5_rec *read = NULL;
    ASSERT(slow5_get("a649a4ae-c43d-492a-b6a1-a5b8b8076be4", &read, s5p) == 0);
    int err;
    char *cn = slow5_aux_get_string(read, "channel_number", NULL, &err);
    ASSERT(cn != NULL);
    ASSERT(strcmp(cn, "115") == 0);
    ASSERT(err == 0);
    double mb = slow5_aux_get_double(read, "median_before", &err);
    ASSERT(mb == 225.114);
    ASSERT(err == 0);
    ASSERT(slow5_aux_get_int32(read, "read_number", &err) == 222);
    ASSERT(err == 0);
    ASSERT(slow5_aux_get_uint8(read, "start_mux", &err) == 1);
    ASSERT(err == 0);
    ASSERT(slow5_aux_get_uint64(read, "start_time", &err) == 2817564);
    ASSERT(err == 0);

    slow5_rec_free(read);

    ASSERT(slow5_close(s5p) == 0);

    return EXIT_SUCCESS;
}

int slow5_duplicate(void) {
    struct slow5_file *s5p = slow5_open("test/data/exp/one_fast5/exp_1_lossless.slow5", "r");
    ASSERT(s5p != NULL);

    ASSERT(slow5_hdr_print(s5p->header, SLOW5_FORMAT_ASCII, SLOW5_COMPRESS_NONE) != -1);

    struct slow5_rec *read = NULL;
    ASSERT(slow5_get_next(&read, s5p) == 0);
    ASSERT(slow5_rec_print(read, s5p->header->aux_meta, SLOW5_FORMAT_ASCII, NULL) != -1);
    slow5_rec_free(read);

    ASSERT(slow5_close(s5p) == 0);

    return EXIT_SUCCESS;
}

int slow5_to_blow5_uncomp(void) {
    struct slow5_file *s5p = slow5_open("test/data/exp/one_fast5/exp_1_lossless.slow5", "r");
    ASSERT(s5p != NULL);

    ASSERT(slow5_hdr_print(s5p->header, SLOW5_FORMAT_BINARY, SLOW5_COMPRESS_NONE) != -1);

    struct slow5_rec *read = NULL;
    ASSERT(slow5_get_next(&read, s5p) == 0);
    ASSERT(slow5_rec_print(read, s5p->header->aux_meta, SLOW5_FORMAT_BINARY, NULL) != -1);
    slow5_rec_free(read);

    slow5_eof_print();

    ASSERT(slow5_close(s5p) == 0);

    return EXIT_SUCCESS;
}

int slow5_get_aux_array(void) {

    struct slow5_file *s5p = slow5_open("test/data/exp/aux_array/exp_lossless.slow5", "r");
    ASSERT(s5p != NULL);
    ASSERT(slow5_idx_load(s5p) == 0);

    struct slow5_rec *read = NULL;
    ASSERT(slow5_get("a649a4ae-c43d-492a-b6a1-a5b8b8076be4", &read, s5p) == 0);

    int err;
    uint64_t len;
    int16_t *array = slow5_aux_get_int16_array(read, "test_array", &len, &err);
    ASSERT(err == 0);
    ASSERT(array != NULL);
    ASSERT(len == 5);
    ASSERT(printf("\n") > 0);
    for (uint64_t i = 0; i < len; ++ i) {
        ASSERT(printf("%" PRId16 ",", array[i]) > 0);
    }
    ASSERT(printf("\n") > 0);

    slow5_rec_free(read);

    ASSERT(slow5_close(s5p) == 0);

    return EXIT_SUCCESS;
}

int blow5_get_aux_array(void) {

    struct slow5_file *s5p = slow5_open("test/data/exp/aux_array/exp_lossless.blow5", "r");
    ASSERT(s5p != NULL);
    ASSERT(slow5_idx_load(s5p) == 0);

    struct slow5_rec *read = NULL;
    ASSERT(slow5_get("a649a4ae-c43d-492a-b6a1-a5b8b8076be4", &read, s5p) == 0);

    int err;
    uint64_t len;
    int16_t *array = slow5_aux_get_int16_array(read, "test_array", &len, &err);
    ASSERT(err == 0);
    ASSERT(array != NULL);
    ASSERT(len == 5);
    for (uint64_t i = 0; i < len; ++ i) {
        ASSERT(printf("%" PRId16 ",", array[i]) > 0);
    }
    ASSERT(printf("\n") > 0);

    slow5_rec_free(read);

    ASSERT(slow5_close(s5p) == 0);

    return EXIT_SUCCESS;
}

int blow5_gzip_get_aux_array(void) {

    struct slow5_file *s5p = slow5_open("test/data/exp/aux_array/exp_lossless_gzip.blow5", "r");
    ASSERT(s5p != NULL);
    ASSERT(slow5_idx_load(s5p) == 0);

    struct slow5_rec *read = NULL;
    ASSERT(slow5_get("a649a4ae-c43d-492a-b6a1-a5b8b8076be4", &read, s5p) == 0);

    int err;
    uint64_t len;
    int16_t *array = slow5_aux_get_int16_array(read, "test_array", &len, &err);
    ASSERT(err == 0);
    ASSERT(array != NULL);
    ASSERT(len == 5);
    for (uint64_t i = 0; i < len; ++ i) {
        ASSERT(printf("%" PRId16 ",", array[i]) > 0);
    }
    ASSERT(printf("\n") > 0);

    slow5_rec_free(read);

    ASSERT(slow5_close(s5p) == 0);

    return EXIT_SUCCESS;
}

int slow5_get_hdr_keys_valid(void) {
    struct slow5_file *s5p = slow5_open("test/data/exp/aux_array/exp_lossless.slow5", "r");
    ASSERT(s5p != NULL);

    uint64_t len = 0;
    const char **list = slow5_get_hdr_keys(s5p->header, &len);

    for (uint64_t i = 0; i < len; ++ i) {
        ASSERT(printf("%s\n", list[i]) > 0);
    }
    free(list);

    ASSERT(slow5_close(s5p) == 0);

    return EXIT_SUCCESS;
}

int slow5_get_aux_names_valid(void) {
    struct slow5_file *s5p = slow5_open("test/data/exp/aux_array/exp_lossless.slow5", "r");
    ASSERT(s5p != NULL);

    uint64_t len = 0;
    char **list = slow5_get_aux_names(s5p->header, &len);
    for (uint64_t i = 0; i < len; ++ i) {
        ASSERT(printf("%s\t", list[i]) > 0);
    }
    ASSERT(printf("\n") > 0);

    ASSERT(slow5_close(s5p) == 0);

    return EXIT_SUCCESS;
}

int slow5_set_aux_string(void) {
    struct slow5_file *s5p = slow5_open("test/data/exp/aux_array/exp_lossless.slow5", "r");
    ASSERT(s5p);
    ASSERT(slow5_idx_load(s5p) == 0);

    struct slow5_rec *read = NULL;
    ASSERT(slow5_get("a649a4ae-c43d-492a-b6a1-a5b8b8076be4", &read, s5p) == 0);
    ASSERT(read);

    size_t len;
    char *cn = slow5_aux_get_string(read, "channel_number", &len, NULL);
    ASSERT(cn);
    ASSERT(len == strlen(cn));
    ASSERT(len == strlen("115"));
    ASSERT(strcmp(cn, "115") == 0);

    /* set 115 back using this bloody buggy function to make sure it doesn't ever bug again */
    ASSERT(slow5_rec_set_string(read, s5p->header->aux_meta, "channel_number", cn) == 0);
    ASSERT(slow5_rec_print(read, s5p->header->aux_meta, SLOW5_FORMAT_BINARY, NULL) != -1);

    free(cn);
    slow5_rec_free(read);
    ASSERT(slow5_close(s5p) == 0);

    return EXIT_SUCCESS;
}


int main(void) {


    slow5_set_log_level(SLOW5_LOG_OFF);
    slow5_set_exit_condition(SLOW5_EXIT_OFF);

    struct command tests[] = {
        CMD(slow5_open_valid)
        CMD(slow5_get_valid)
        CMD(slow5_aux_get_valid)
        CMD(slow5_aux_get_invalid)

        CMD(blow5_get_valid)
        CMD(blow5_rec_get_valid)

        CMD(slow5_duplicate)
        CMD(slow5_to_blow5_uncomp)

        CMD(slow5_get_aux_array)
        CMD(blow5_get_aux_array)
        CMD(blow5_gzip_get_aux_array)

        CMD(slow5_get_hdr_keys_valid)
        CMD(slow5_get_aux_names_valid)

        CMD(slow5_set_aux_string)
    };

    return RUN_TESTS(tests);
}
