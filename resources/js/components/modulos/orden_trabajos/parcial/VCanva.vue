<template>
    <div class="row canva">
        <div class="contenedor">
            <div class="card">
                <div class="card-header bg-primary">
                    OT Pendientes ({{ listPendientes.length }})
                </div>
                <div class="card-body bg-info">
                    <div class="row">
                        <div class="col-md-12" v-for="item in listPendientes">
                            <a href="" class="card item">
                                <div class="card-body">
                                    <p class="mb-1">
                                        {{ item.tipo_mantenimiento }}
                                    </p>
                                    <p class="mb-1">
                                        {{ item.fecha_programada }}
                                    </p>
                                    <p class="mb-1">
                                        {{ item.gama.equipo.nombre }}
                                    </p>
                                    <p class="mb-1">
                                        {{ item.gama.descripcion }}
                                    </p>
                                    <p class="mb-1">{{ item.id }}</p>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="contenedor">
            <div class="card">
                <div class="card-header bg-primary">
                    OT Iniciados ({{ listIniciados.length }})
                </div>
                <div class="card-body bg-info">
                    <div class="row">
                        <div class="col-md-12" v-for="item in listIniciados">
                            <a href="" class="card item">
                                <div class="card-body">
                                    <p class="mb-1">
                                        {{ item.tipo_mantenimiento }}
                                    </p>
                                    <p class="mb-1">
                                        {{ item.fecha_programada }}
                                    </p>
                                    <p class="mb-1">
                                        {{ item.gama.equipo.nombre }}
                                    </p>
                                    <p class="mb-1">
                                        {{ item.gama.descripcion }}
                                    </p>
                                    <p class="mb-1">{{ item.id }}</p>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="contenedor">
            <div class="card">
                <div class="card-header bg-primary">
                    OT Programados ({{ listProgramados.length }})
                </div>
                <div class="card-body bg-info">
                    <div class="row">
                        <div class="col-md-12" v-for="item in listProgramados">
                            <a href="" class="card item">
                                <div class="card-body">
                                    <p class="mb-1">
                                        {{ item.tipo_mantenimiento }}
                                    </p>
                                    <p class="mb-1">
                                        {{ item.fecha_programada }}
                                    </p>
                                    <p class="mb-1">
                                        {{ item.gama.equipo.nombre }}
                                    </p>
                                    <p class="mb-1">
                                        {{ item.gama.descripcion }}
                                    </p>
                                    <p class="mb-1">{{ item.id }}</p>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="contenedor">
            <div class="card">
                <div class="card-header bg-primary">
                    OT Cancelados ({{ listCancelados.length }})
                </div>
                <div class="card-body bg-info">
                    <div class="row">
                        <div class="col-md-12" v-for="item in listCancelados">
                            <a href="" class="card item">
                                <div class="card-body">
                                    <p class="mb-1">
                                        {{ item.tipo_mantenimiento }}
                                    </p>
                                    <p class="mb-1">
                                        {{ item.fecha_programada }}
                                    </p>
                                    <p class="mb-1">
                                        {{ item.gama.equipo.nombre }}
                                    </p>
                                    <p class="mb-1">
                                        {{ item.gama.descripcion }}
                                    </p>
                                    <p class="mb-1">{{ item.id }}</p>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="contenedor">
            <div class="card">
                <div class="card-header bg-primary">
                    OT Terminados ({{ listTerminados.length }})
                </div>
                <div class="card-body bg-info">
                    <div class="row">
                        <div class="col-md-12" v-for="item in listTerminados">
                            <a href="" class="card item">
                                <div class="card-body">
                                    <p class="mb-1">
                                        {{ item.tipo_mantenimiento }}
                                    </p>
                                    <p class="mb-1">
                                        {{ item.fecha_programada }}
                                    </p>
                                    <p class="mb-1">
                                        {{ item.gama.equipo.nombre }}
                                    </p>
                                    <p class="mb-1">
                                        {{ item.gama.descripcion }}
                                    </p>
                                    <p class="mb-1">{{ item.id }}</p>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
export default {
    props: {
        mostrando: {
            type: Boolean,
            default: false,
        },
    },
    watch: {
        mostrando: function (newVal, oldVal) {
            console.log(newVal);
            if (newVal) {
                this.getOrdenTrabajosClasificados();
            }
        },
    },
    data() {
        return {
            listPendientes: [],
            listIniciados: [],
            listProgramados: [],
            listCancelados: [],
            listTerminados: [],
            cargando: true,
        };
    },
    mounted() {
        if (this.mostrando) {
            this.getOrdenTrabajosClasificados();
        }
    },
    methods: {
        // Listar OrdenTrabajos
        getOrdenTrabajosClasificados() {
            this.cargando = true;
            let url = "/admin/orden_trabajos/lista_clasificados";
            axios.get(url).then((res) => {
                this.listPendientes = res.data.pendientes;
                this.listIniciados = res.data.iniciados;
                this.listProgramados = res.data.programados;
                this.listCancelados = res.data.cancelados;
                this.listTerminados = res.data.terminados;
                let self = this;
                setTimeout(() => {
                    self.cargando = false;
                }, 700);
            });
        },
    },
};
</script>

<style>
.canva {
    display: grid;
    gap: 5px;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
}

.canva .item {
    color: black;
    font-size: 0.94em;
    font-weight: 600;
}
</style>
