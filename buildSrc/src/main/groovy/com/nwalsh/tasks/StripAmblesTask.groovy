package com.nwalsh.tasks

import org.gradle.api.DefaultTask
import org.gradle.api.tasks.TaskAction
import org.gradle.api.tasks.InputFile
import org.gradle.api.tasks.OutputFile
import org.gradle.api.tasks.incremental.IncrementalTaskInputs

// ================================================================================
// Strip pre-amble and post-amble from examples so that the example on disk
// is a runable pipeline but the excerpt in the spec is just the interesting
// section. (Basically everything before the first blank line and everything
// after the last blank line is deleted.

class StripAmblesTask extends DefaultTask {
    @InputFile
    def File input

    @OutputFile
    def File output

    @TaskAction
    void execute(IncrementalTaskInputs inputs) {
      def lines = input.readLines()
      def firstBlank = -1;
      def lastBlank = -1;
      def pos = -1;
      lines.each { String line ->
        pos++;
        if (line.trim() == "") {
          lastBlank = pos;
          if (firstBlank < 0) {
            firstBlank = pos;
          }
        }
      }

      output.write("")
      pos = -1
      lines.each { String line ->
        pos++;
        if (pos > firstBlank && pos < lastBlank) {
          output << line + "\n"
        }
      }
    }
}
