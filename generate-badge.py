import subprocess
import os.path
import click

@click.command()
@click.option('--rows', '-r', required=True, type=int, prompt="Rows of pips")
@click.option('--cols', '-c', required=True, type=int, prompt="Columns of pips")
@click.option('--name', '-n', required=True, default="badge-rc4", type=str, prompt="Name of badge")
@click.option('--dir', '-d', type=click.Path(exists=True, file_okay=False, dir_okay=True, resolve_path=True), default='output/')
@click.argument('text-lines', nargs=-1, type=str)
def make_stls(rows, cols, name, text_lines, dir):
     texts=','.join(f'"{line}"' for line in text_lines)
     for export_type in ('badge', 'pips', 'text'):
          out_file = f'{name}-{cols}x{rows}-{export_type}.stl'
          out_path = os.path.join(dir, out_file)
          subprocess.run([
               'openscad',
               '-D', f'TEXT=[{texts}]',
               '-D', f'PIP_COLS={cols}',
               '-D', f'PIP_ROWS={rows}',
               '-D', f'EXPORT="{export_type}"',
               '-o', out_path,
               'badge.scad'
          ])

if __name__ == '__main__':
     make_stls()
