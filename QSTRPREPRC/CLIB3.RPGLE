      /if not defined(CLIB3)
      /define CLIB3
      *
     d EOF             c                   const(-1)
      *
      *  fopen() -- Open files
      *    #include <stdio.h>
      *    FILE *fopen(const char *filename, const char *mode);
      /if defined(USE_IFS_IO)
     d fopen           pr              *          extproc('_C_IFS_fopen')
      /else
     d fopen           pr              *          extproc('fopen')
      /endif
     d  i_fileName                     *   value  options(*string)
     d  i_mode                         *   value  options(*string)
      *
      *  fclose -- Close stream
      *    #include <stdio.h>
      *    int fclose(FILE *stream);
      /if defined(USE_IFS_IO)
     d fclose          pr            10i 0        extproc('_C_IFS_fclose')
      /else
     d fclose          pr            10i 0        extproc('fclose')
      /endif
     d  i_stream                       *   value
      *
      *  fwrite -- Write Items
      *    #include <stdio.h>
      *    size_t fwrite(const void *buffer, size_t size, size_t count, FILE *stream);
      /if defined(USE_IFS_IO)
     d fwrite          pr            10u 0        extproc('_C_IFS_fwrite')
      /else
     d fwrite          pr            10u 0        extproc('fwrite')
      /endif
     d  i_pData                        *   value
     d  i_size                       10u 0 value
     d  i_count                      10u 0 value
     d  i_stream                       *   value
      *
      *  fgets -- Read a String
      *    #include <stdio.h>
      *    char *fgets (char *string, int n, FILE *stream);
      /if defined(USE_IFS_IO)
     d fgets           pr              *          extproc('_C_IFS_fgets')
      /else
     d fgets           pr              *          extproc('fgets')
      /endif
     d  i_pString                      *   value
     d  i_size                       10i 0 value
     d  i_stream                       *   value
      *
      *  feof -- Test End-of-File Indicator
      *    #include <stdio.h>
      *    int feof(FILE *stream);
      /if defined(USE_IFS_IO)
     d feof            pr            10i 0        extproc('_C_IFS_feof')
      /else
     d feof            pr              *          extproc('feof')
      /endif
     d  i_stream                       *   value
      *
      /endif
