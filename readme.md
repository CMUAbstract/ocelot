The folder **Benchmarks**  contains the rust source code of the benchmarks. 
The subfolders are titled with the name of the contained application, and each subfolder 
has the files:
* **unaltered.rs** - the unadorned rust application code
* **annotated.rs** - a version with fresh and consistent annotations added and comments 
  indicating where the bounds of the inferred regions would go (approximately, since regions 
  are inferred at the IR level, not the source code level)
* **<name_of_app>_post.ll** - the LLVM IR representation of the program after region inferrence. Search for 
  "atomic_start" or "atomic_end" to see the region beginning and ending respectively.

Note that each folder does not contain all all the dependencies necessary to compile and run the benchmark 
(e.g., the 'C' main stub or any other external functions), but is organized so that one is able to quickly compare the annotated and unnotated code versions and see the inferred regions.

## Ocelot compiler code 

Coming soon.

## Guide on building Ocelot applications

Coming soon.

