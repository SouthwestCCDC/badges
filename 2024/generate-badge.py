import subprocess
import os.path
import pathlib
import click

@click.command()
@click.option('--rows', '-r', required=True, type=int, prompt="Rows of pips")
@click.option('--cols', '-c', required=True, type=int, prompt="Columns of pips")
@click.option('--name', '-n', required=True, default="badge-rc4", type=str, prompt="Name of badge")
@click.option('--output-dir', '-o', type=click.Path(file_okay=False, dir_okay=True, resolve_path=True), default='output/')
@click.option('--pip-colors', '-p', type=str, default='blue', help="Comma-separated row-first list of color names", prompt="Color list")
@click.option('--font-size', '-Fs', type=float)
@click.option('--rebel/--empire', default=False, help="Sets which faction this badge is.")
@click.argument('text-lines', nargs=-1, type=str)
def make_stls(rows, cols, name, output_dir, pip_colors, font_size, text_lines, rebel):
     texts=','.join(f'"{line}"' for line in text_lines)

     pip_color_list = ','.join(f'"{color}"' for color in map(str.strip, pip_colors.split(',')))

     # Make sure the directory exists.
     pathlib.Path(output_dir).mkdir(parents=True, exist_ok=True)

     for export_type in ('badge', 'pips', 'text', 'all'):
          out_file = f'{name}-{cols}x{rows}-{export_type}'
          if export_type == 'all':
               out_file += '.png'
          else:
               out_file += '.stl'
          out_path = os.path.join(output_dir, out_file)
          cmd = [
               'openscad',
               '-D', f'TEXT=[{texts}]',
               '-D', f'PIP_COLORS=[{pip_color_list}]',
               '-D', f'PIP_COLS={cols}',
               '-D', f'PIP_ROWS={rows}',
               '-D', f'EXPORT="{export_type}"',
               '-D', f'PIP_RECESS=0',
               '-o', out_path,
          ]

          if font_size:
               cmd += [
                    '-D', f'TXT_SIZE={font_size}'
               ]
          
          if rebel:
               cmd += [
                    '-D', 'REBEL=true'
               ]

          cmd += ['badge.scad']

          print(' '.join(cmd))
          subprocess.run(cmd)

if __name__ == '__main__':
     make_stls()
